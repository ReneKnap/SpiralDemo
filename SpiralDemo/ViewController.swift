//
//  ViewController.swift
//  SpiralDemo
//
//  Created by Creatcher on 23.11.21.
//

import UIKit

class ViewController: UIViewController, UIColorPickerViewControllerDelegate{
    let step: Float = 5
    let maxRadius: Float = 500
    
    var spiralColor = UIColor.white
    var lastSpiral = UIImage()
    
    var addButton: UIButton!
    var colorPickerButton: UIButton!
    var resetButton: UIButton!
    
    var posYSlider: UISlider!
    var radius1Slider: UISlider!
    var radius2Slider: UISlider!
    var travelSlider: UISlider!
    
    var spiralImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUIElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateSpiral()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func loadUIElements() {
        view.backgroundColor = UIColor.black
        
        addButton = UIButton(type: .system)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addSpiral),
                            for: .touchUpInside)
        addButton.backgroundColor = UIColor.darkGray
        addButton.layer.cornerRadius = 5
        view.addSubview(addButton)
        
        colorPickerButton = UIButton(type: .system)
        colorPickerButton.translatesAutoresizingMaskIntoConstraints = false
        colorPickerButton.setTitle("Color Picker", for: .normal)
        colorPickerButton.addTarget(self, action: #selector(selectColor),
                                    for: .touchUpInside)
        colorPickerButton.backgroundColor = UIColor.darkGray
        colorPickerButton.layer.cornerRadius = 5
        view.addSubview(colorPickerButton)
        
        resetButton = UIButton(type: .system)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle("Clear", for: .normal)
        resetButton.addTarget(self, action: #selector(clearSpiral),
                              for: .touchUpInside)
        resetButton.backgroundColor = UIColor.darkGray
        resetButton.layer.cornerRadius = 5
        view.addSubview(resetButton)
       
        spiralImage = UIImageView()
        spiralImage.translatesAutoresizingMaskIntoConstraints = false
        spiralImage.backgroundColor = UIColor.darkGray
        spiralImage.layer.cornerRadius = 15
        spiralImage.clipsToBounds = true
        view.addSubview(spiralImage)
        
        posYSlider = UISlider()
        posYSlider.translatesAutoresizingMaskIntoConstraints = false
        posYSlider.minimumValue = step
        posYSlider.maximumValue = maxRadius
        posYSlider.value = 50
        posYSlider.addTarget(self, action: #selector(updateSpiralWithTravel),
                             for: .allTouchEvents)
        view.addSubview(posYSlider)
        
        radius1Slider = UISlider()
        radius1Slider.translatesAutoresizingMaskIntoConstraints = false
        radius1Slider.minimumValue = step
        radius1Slider.maximumValue = maxRadius
        radius1Slider.value = 160
        radius1Slider.addTarget(self, action: #selector(updateSpiralWithTravel),
                                for: .allTouchEvents)
        view.addSubview(radius1Slider)
        
        radius2Slider = UISlider()
        radius2Slider.translatesAutoresizingMaskIntoConstraints = false
        radius2Slider.minimumValue = step
        radius2Slider.maximumValue = maxRadius
        radius2Slider.value = 70
        radius2Slider.addTarget(self, action: #selector(updateSpiralWithTravel),
                                for: .allTouchEvents)
        view.addSubview(radius2Slider)
        
        travelSlider = UISlider()
        travelSlider.translatesAutoresizingMaskIntoConstraints = false
        travelSlider.minimumValue = 0
        travelSlider.maximumValue = 4000.0
        travelSlider.value = 0
        travelSlider.addTarget(self, action: #selector(updateSpiralWithTravel),
                               for: .allTouchEvents)
        view.addSubview(travelSlider)
        

        NSLayoutConstraint.activate([
            spiralImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                                             constant: 32),
            spiralImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spiralImage.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor,
                                                multiplier: 0.70),
            spiralImage.widthAnchor.constraint(equalTo: view.widthAnchor,
                                               constant: -100),
            
            addButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                              constant: -32),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 64),
            addButton.widthAnchor.constraint(equalToConstant: 128),
            
            colorPickerButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                                      constant: -32),
            colorPickerButton.rightAnchor.constraint(equalTo: addButton.leftAnchor,
                                                     constant: -32),
            colorPickerButton.heightAnchor.constraint(equalToConstant: 64),
            colorPickerButton.widthAnchor.constraint(equalToConstant: 128),
            
            resetButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                                constant: -32),
            resetButton.leftAnchor.constraint(equalTo: addButton.rightAnchor,
                                              constant: 32),
            resetButton.heightAnchor.constraint(equalToConstant: 64),
            resetButton.widthAnchor.constraint(equalToConstant: 128),
            
            radius1Slider.bottomAnchor.constraint(equalTo: addButton.topAnchor,
                                                  constant: -16),
            radius1Slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            radius1Slider.heightAnchor.constraint(equalToConstant: 44),
            radius1Slider.widthAnchor.constraint(equalToConstant: 512),
            
            radius2Slider.bottomAnchor.constraint(equalTo: radius1Slider.topAnchor),
            radius2Slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            radius2Slider.heightAnchor.constraint(equalToConstant: 44),
            radius2Slider.widthAnchor.constraint(equalToConstant: 512),
            
            posYSlider.bottomAnchor.constraint(equalTo: radius2Slider.topAnchor),
            posYSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posYSlider.heightAnchor.constraint(equalToConstant: 44),
            posYSlider.widthAnchor.constraint(equalToConstant: 512),
            
            travelSlider.bottomAnchor.constraint(equalTo: posYSlider.topAnchor),
            travelSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            travelSlider.heightAnchor.constraint(equalToConstant: 44),
            travelSlider.widthAnchor.constraint(equalToConstant: 512)
        ])
    }
    
    @objc func clearSpiral() {
        lastSpiral = UIImage()
        posYSlider.value = 50
        radius1Slider.value = 160
        radius2Slider.value = 70
        updateSpiral()
    }
    
    @objc func addSpiral() {
        updateSpiral()
        lastSpiral = spiralImage.image ?? UIImage()
        posYSlider.value = 50
        radius1Slider.value = 160
        radius2Slider.value = 70
        updateSpiral()
    }
    
    
    @objc func updateSpiral() {
        var roundedValue = round(radius1Slider.value / step) * step
        radius1Slider.value = roundedValue
        
        roundedValue = round(radius2Slider.value / step) * step
        radius2Slider.value = roundedValue
        
        spiralImage.image = drawSpiral(size: spiralImage.frame.size,
                                       radius1: CGFloat(radius1Slider.value),
                                       radius2: CGFloat(radius2Slider.value),
                                       pos: CGPoint(x: 0, y: CGFloat(posYSlider.value)))
    }
    
    @objc func selectColor() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)
        
    }
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        spiralColor = viewController.selectedColor
        updateSpiral()
    }
    
    @objc func updateSpiralWithTravel() {
        var roundedValue = round(radius1Slider.value / step) * step
        radius1Slider.value = roundedValue
        roundedValue = round(radius2Slider.value / step) * step
        radius2Slider.value = roundedValue
        
        if travelSlider.value == 0 {
            updateSpiral()
            return
        }
        
        spiralImage.image = drawSpiralWithStencils(size: spiralImage.frame.size,
                                                   radius1: CGFloat(radius1Slider.value),
                                                   radius2: CGFloat(radius2Slider.value),
                                                   pos: CGPoint(x: 0,
                                                                y: CGFloat(posYSlider.value)),
                                                   travelDistance: CGFloat(travelSlider.value))
    }
    
    
    func getSpiralPoint(travelDistance: CGFloat, radius1: CGFloat,
                        radius2: CGFloat, pos: CGPoint) -> CGPoint {
        let rotationAngle1 = getRotationAngle(of: radius1, with: travelDistance)
        let rotationAngle2 = getRotationAngle(of: radius2, with: travelDistance)

        let transform = CGAffineTransform(rotationAngle: -rotationAngle1)
            .translatedBy(x: 0, y: -radius2 + radius1)
            .rotated(by: rotationAngle2)
            .translatedBy(x: pos.x, y: pos.y)

        return .zero.applying(transform)
    }
    
    func getSecondCircleCenter(travelDistance: CGFloat, radius1: CGFloat,
                               radius2: CGFloat, pos: CGPoint) -> CGPoint {
        let rotationAngle1 = getRotationAngle(of: radius1, with: travelDistance)

        let transform = CGAffineTransform(rotationAngle: -rotationAngle1)
            .translatedBy(x: 0, y: -radius2 + radius1)
        
        return .zero.applying(transform)
    }
    
    func drawSpiral(size: CGSize, radius1: CGFloat, radius2: CGFloat,
                    pos: CGPoint, travelDistance: CGFloat = 30000) -> UIImage {
        print(radius1)
        print(radius2)
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let img = renderer.image { ctx in
            lastSpiral.draw(at: .zero)
            let startPoint = getSpiralPoint(travelDistance: 0.0,
                                            radius1: radius1,
                                            radius2: radius2,
                                            pos: pos)
            ctx.cgContext.translateBy(x: size.width/2, y: size.height/2)
            ctx.cgContext.move(to: startPoint)
            
            let maxTravelNeed = 1 / CGFloat(gcd(Int(radius1),Int(radius2)))
                * min(radius1, radius2)
                * max(radius1, radius2)
            
            for i in 0 ..< Int(travelDistance) {
                let nextPoint = getSpiralPoint(travelDistance: CGFloat(i),
                                              radius1: radius1,
                                              radius2: radius2,
                                              pos: pos)
                ctx.cgContext.addLine(to: nextPoint)
                if i > Int(maxTravelNeed) {
                    print(i)
                    break
                }
            }
            ctx.cgContext.setLineWidth(3)
            ctx.cgContext.setStrokeColor(spiralColor.cgColor)
            ctx.cgContext.strokePath()
        }
        return img
    }
    
    func drawSpiralWithStencils(size: CGSize, radius1: CGFloat, radius2: CGFloat,
                                pos: CGPoint, travelDistance: CGFloat) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let tepImg = renderer.image { ctx in
            drawSpiral(size: size, radius1: radius1, radius2: radius2, pos: pos,
                       travelDistance: travelDistance > 0 ? travelDistance : 30000)
                .draw(at: CGPoint(x: 0, y: 0))
            ctx.cgContext.translateBy(x: size.width/2, y: size.height/2)
            

            ctx.cgContext.addEllipse(in: CGRect(x: -radius1,
                                                y: -radius1,
                                                width: radius1*2,
                                                height: radius1*2))
            
            let posSecondCircle = getSecondCircleCenter(travelDistance: travelDistance,
                                                        radius1: radius1,
                                                        radius2: radius2,
                                                        pos: pos)
            ctx.cgContext.translateBy(x: posSecondCircle.x, y: posSecondCircle.y)
            
            
            
            ctx.cgContext.addEllipse(in: CGRect(x: -radius2,
                                                y: -radius2,
                                                width: radius2*2,
                                                height: radius2*2))

            ctx.cgContext.setStrokeColor(UIColor.gray.cgColor)
            ctx.cgContext.setLineWidth(4)
            ctx.cgContext.strokePath()
        }
        
        let finalImg = renderer.image { ctx in
            tepImg.draw(at: CGPoint(x: 0, y: 0))
            ctx.cgContext.translateBy(x: size.width/2, y: size.height/2)

            let dotPosition = getSpiralPoint(travelDistance: travelDistance, radius1: radius1,
                                             radius2: radius2, pos: pos)
            ctx.cgContext.move(to: getSecondCircleCenter(travelDistance: travelDistance,
                                                         radius1: radius1,
                                                         radius2: radius2,
                                                         pos: pos))
            ctx.cgContext.addLine(to: dotPosition)
            ctx.cgContext.setStrokeColor(UIColor.gray.cgColor)
            ctx.cgContext.setLineWidth(2)
            ctx.cgContext.strokePath()
            ctx.cgContext.addEllipse(in: CGRect(origin: CGPoint(x: dotPosition.x - 4,
                                                                y: dotPosition.y - 4),
                                                size: CGSize(width: 8, height: 8)))
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.fillPath()

        }
        return finalImg
    }
}

func gcd(_ a: Int, _ b: Int) -> Int {
    let c = a % b
    if c != 0 {
        return gcd(b, c)
    } else {
        return b
    }
}

func getRotationAngle(of radius: CGFloat, with travel: CGFloat) -> CGFloat {
    return (1 / radius * travel) * .pi * 2
}

