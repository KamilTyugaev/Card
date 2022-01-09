//
//  Cards.swift
//  Cards
//
//  Created by IosDeveloper on 04.01.2022.
//

import UIKit

class CardView<ShapeType : ShapeLayerProtocol>: UIView,FlippableView {
    //точка привязки
    private var anchorPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var starTouchPoint: CGPoint!
    var isFlipped: Bool = false {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    var flipCompletionHandler: ((FlippableView) -> Void)?
    
    func flip() {
        let fromView = isFlipped ? frontSideView : backSideView
        let toView = isFlipped ? backSideView : frontSideView
        //run animation transfer
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.transitionFlipFromTop], completion: { _ in
            self.flipCompletionHandler?(self)
        })

        isFlipped.toggle()
    }
    
    var color: UIColor!
    var cornerRadius = 20
    

    init(frame:CGRect, color:UIColor){
        super.init(frame: frame)
        self.color = color
        
        setupBorders()
    }
    private func setupBorders(){
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    private let margin: Int = 10
    
    lazy var frontSideView: UIView = self.getFrontSideView()
    lazy var backSideView: UIView = self.getBackSideView()
    
    private func getFrontSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        
        let shapeView = UIView(frame: CGRect(
                                    x: margin,
                                    y:margin,
                                    width: Int(self.bounds.width) - margin*2,
                                    height: Int(self.bounds.height)-margin*2))
        view.addSubview(shapeView)
        
        //create layer with figure
        let shapeLayer = ShapeType(size: shapeView.frame.size, fiilColor: color.cgColor)
        shapeView.layer.addSublayer(shapeLayer)
        // скругляем углы корневого слоя
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        return view
    }
    
    private func getBackSideView() -> UIView{
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        
        //выбок случайного узора для рубашки
        switch ["circle","line"].randomElement()! {
        case "circle":
            let layer = BaсkSideCircle(size: self.bounds.size, fiilColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        case "line":
            let layer = BackSideLine(size: self.bounds.size, fiilColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        default:
            break
        }
        // скругляем углы корневого слоя
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        return view
    }
    
    override func draw(_ rect: CGRect) {
        // удаляем добавленные ранее дочерние представления
        backSideView.removeFromSuperview()
        frontSideView.removeFromSuperview()
        
            //add new view
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
        }else{
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        anchorPoint.x = touches.first!.location(in: window).x - frame.minX
        anchorPoint.y = touches.first!.location(in: window).y - frame.minY
        
        //save data out coordinate
        starTouchPoint = frame.origin

    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        self.frame.origin.x = touches.first!.location(in: window).x - anchorPoint.x
        self.frame.origin.y = touches.first!.location(in: window).y - anchorPoint.y
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        if self.frame.origin == starTouchPoint{
        flip()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol FlippableView:UIView {
    var isFlipped: Bool { get set }
    var flipCompletionHandler: ( (FlippableView) -> Void)? { get set }
    func flip()
}

extension UIResponder{
    func respoderChains() -> String{
        guard let next = next else {
            return String(describing: Self.self)
        }
        return String(describing: Self.self) + "->" + next.respoderChains()
    }
}
