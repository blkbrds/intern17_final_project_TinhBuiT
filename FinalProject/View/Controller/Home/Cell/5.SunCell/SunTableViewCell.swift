//
//  SunTableViewCell.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/15/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class SunTableViewCell: UITableViewCell {

    // MARK: - Properties
    var semiCircleLayer = CAShapeLayer()
    let shape = CAShapeLayer()
    private var points: [CGPoint] = []
    let sunImage = UIImageView(image: UIImage(named: "sun"))
    var realTime: Double = 0.0

    override func awakeFromNib() {
        configView()
    }

    var sunset: String = "" {
        didSet {
            updateSunSet(timeString: sunset)
        }
    }

    var sunrise: String = "" {
        didSet {
            updateSunRise(timeString: sunrise)
        }
    }

    var viewModel: SunTableViewCellViewModel? {
        didSet {
            configView()
            updateView()
        }
    }

    // MARK: - IBOutlets
    @IBOutlet weak var myCircleView: UIView!

    // MARK: - Private functions
    private func updateSunRise(timeString: String) {
        let timeSun = UILabel(frame: CGRect(x: 5, y: myCircleView.bounds.size.height - 45, width: 50, height: 35))
        timeSun.textColor = .white
        timeSun.text = timeString
        myCircleView.addSubview(timeSun)
    }

    private func updateSunSet(timeString: String) {
        let timeSet = UILabel(frame: CGRect(x: myCircleView.bounds.size.width - 40, y: myCircleView.bounds.size.height - 45, width: 50, height: 35))
        timeSet.textColor = .white
        timeSet.text = timeString
        myCircleView.addSubview(timeSet)
    }

    private func configView() {
        let heightCell = UIScreen.main.bounds.width / 2 + 100
        let center = CGPoint (x: myCircleView.frame.size.width / 2, y: myCircleView.frame.size.height - 50)
        let circleRadius = myCircleView.frame.size.width / 2 - 20
        let circlePath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat( M_PI * 2), clockwise: true)

        semiCircleLayer.path = circlePath.cgPath
        semiCircleLayer.strokeColor = UIColor.yellow.cgColor
        semiCircleLayer.lineWidth = 1
        semiCircleLayer.fillColor = nil
        semiCircleLayer.lineDashPattern = [3, 3]
        semiCircleLayer.strokeEnd = 1
        myCircleView.layer.addSublayer(semiCircleLayer)
        sunImage.frame = CGRect(x: 5, y: (myCircleView.frame.size.height - 65), width: 30, height: 30)
        myCircleView.addSubview(sunImage)

        let orbit = CAKeyframeAnimation(keyPath: "position")
        let circlePathRun = UIBezierPath(arcCenter: center, radius: circleRadius,
                                       startAngle: CGFloat(M_PI ),
                                       endAngle: CGFloat(M_PI * realTime), clockwise: true)

        orbit.path = circlePathRun.cgPath
        orbit.duration = 2.9
        points.append(circlePathRun.currentPoint)
        sunImage.center = points.last ?? CGPoint()
        sunImage.layer.add(orbit, forKey: "orbit")

        shape.path = circlePathRun.cgPath
        shape.strokeColor = UIColor.systemYellow.cgColor
        shape.fillColor = nil
        shape.strokeEnd = 0
        myCircleView.layer.addSublayer(shape)

        let animate = CABasicAnimation(keyPath: "strokeEnd")
        animate.toValue = M_PI
        animate.duration = 8.7
        animate.isRemovedOnCompletion = false
        animate.fillMode = .forwards
        shape.add(animate, forKey: "animate")

        let path = UIBezierPath(arcCenter: CGPoint(x: myCircleView.frame.size.width / 2, y: myCircleView.frame.size.height - 50), radius: myCircleView.frame.size.width / 2 - 20, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI * realTime), clockwise: true)
        UIColor.orange.setFill()
        path.fill()

        drawLine(start: CGPoint(x: 0, y: heightCell - 101),
                 end: CGPoint(x: myCircleView.bounds.size.width, y: heightCell - 101))
    }

    private func drawLine(start: CGPoint, end: CGPoint) {

            let path = UIBezierPath()
            path.move(to: start)
            path.addLine(to: end)
            path.close()

            let shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = UIColor.systemYellow.cgColor
            shapeLayer.lineWidth = 1.0
            shapeLayer.path = path.cgPath

            self.myCircleView.layer.addSublayer(shapeLayer)
        }

    private func updateView() {
        guard let viewModel = viewModel,
              let sunriseDouble = viewModel.mainApi?.daily?.first?.sunrise,
              let sunsetDouble = viewModel.mainApi?.daily?.first?.sunset,
              let dtTime = viewModel.mainApi?.hourly?.first?.dt
        else { return }
        realTime = (dtTime - sunriseDouble ) / (sunsetDouble - sunriseDouble) + 1
        sunrise = viewModel.utcToHour(date: sunriseDouble)
        sunset = viewModel.utcToHour(date: sunsetDouble)
    }
}
