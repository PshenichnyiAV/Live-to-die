//
//  CircleProgress.swift
//  Play2Live
//
//  Created by Алексей on 14.08.2022.
//

import UIKit

 protocol SRCountdownTimerDelegate: AnyObject {
   func timerDidUpdateCounterValue(sender: SRCountdownTimer, newValue: Int)
    func timerDidStart(sender: SRCountdownTimer)
    func timerDidPause(sender: SRCountdownTimer)
    func timerDidResume(sender: SRCountdownTimer)
    func timerDidEnd(sender: SRCountdownTimer, elapsedTime: TimeInterval)
}

class SRCountdownTimer: UIView {
     public var lineWidth: CGFloat = 2.0
     public var lineColor: UIColor = .black
     public var trailLineColor: UIColor = UIColor.lightGray.withAlphaComponent(0.2)
    
     public var isLabelHidden: Bool = false
     public var labelFont: UIFont?
     public var labelTextColor: UIColor?
     public var timerFinishingText: String?

    weak var delegate: SRCountdownTimerDelegate?
    
    // use minutes and seconds for presentation
    public var useMinutesAndSecondsRepresentation = false
    public var moveClockWise = true

    private var timer: Timer?
    private var beginingValue: Int = 1
    private var totalTime: TimeInterval = 1
    private var elapsedTime: TimeInterval = 0
    private var interval: TimeInterval = 1 // Interval which is set by a user
    private let fireInterval: TimeInterval = 0.01 // ~60 FPS
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        

        label.textAlignment = .center
        label.numberOfLines = 0
        if let font = self.labelFont {
            label.font = font
        }
        if let color = self.labelTextColor {
            label.textColor = color
        }

        return label
    }()
    
    private var currentCounterValue: Int = 0 {
        didSet {
            if !self.isLabelHidden {
                if let text = self.timerFinishingText, self.currentCounterValue == 0 {
                    self.counterLabel.text = text
                } else {
                    if self.useMinutesAndSecondsRepresentation {
                        self.counterLabel.text = self.currentCounterValue <= 60 ? "\(self.currentCounterValue)" : self.getMinutesAndSeconds(remainingSeconds: self.currentCounterValue)
                    } else {
                        self.counterLabel.text = "\(self.currentCounterValue)"
                    }
                }
            }

            self.delegate?.timerDidUpdateCounterValue(sender: self, newValue: self.currentCounterValue)
        }
    }

    // MARK: Inits
    override public init(frame: CGRect) {
        if frame.width != frame.height {
            fatalError("Please use a rectangle frame for SRCountdownTimer")
        }

        super.init(frame: frame)

        self.layer.cornerRadius = frame.width / 2
        self.clipsToBounds = true
       
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        let context = UIGraphicsGetCurrentContext()
        let radius = (rect.width - self.lineWidth) / 2
        
        var currentAngle: CGFloat?
        
        if self.moveClockWise {
            currentAngle = CGFloat((.pi * 2 * self.elapsedTime) / self.totalTime)
        } else {
            currentAngle = CGFloat(-(.pi * 2 * self.elapsedTime) / self.totalTime)
        }
    
        context?.setLineWidth(self.lineWidth)

        // Main line
        context?.beginPath()
        context?.setLineCap(.round)
        context?.addArc(
            center: CGPoint(x: rect.midX, y:rect.midY),
            radius: radius,
            startAngle: (currentAngle ?? 0) - .pi / 2,
            endAngle: .pi * 2 - .pi / 2,
            clockwise: false)
        context?.setStrokeColor(self.lineColor.cgColor)
        context?.strokePath()

// Trail line
        context?.beginPath()
        context?.addArc(
            center: CGPoint(x: rect.midX, y:rect.midY),
            radius: radius,
            startAngle: -.pi / 2,
            endAngle: (currentAngle ?? 0) - .pi / 2,
            clockwise: false)
        context?.setStrokeColor(self.trailLineColor.cgColor)
        context?.strokePath()
        addCounterLabel()
    }

    // MARK: Public methods
    /**
     * Starts the timer and the animation. If timer was previously runned, it'll invalidate it.
     * - Parameters:
     *   - beginingValue: Value to start countdown from.
     *   - interval: Interval between reducing the counter(1 second by default) !!!!!!!
     */
    public func start(beginingValue: Int, elapsedTime: TimeInterval = 0, interval: TimeInterval = 1) {
        self.beginingValue = beginingValue
        self.interval = interval

        self.totalTime = TimeInterval(beginingValue) * interval
        self.elapsedTime = elapsedTime // начало элипса
        self.currentCounterValue = beginingValue

        self.timer?.invalidate()
        self.timer = Timer(timeInterval: fireInterval, target: self, selector: #selector(timerFired(_:)), userInfo: nil, repeats: true)

        RunLoop.main.add(timer ?? Timer(), forMode: .common)

        self.delegate?.timerDidStart(sender: self)
    }

    /**
     * Pauses the timer with saving the current state
     */
    public func pause() {
        self.timer?.fireDate = .distantFuture

        self.delegate?.timerDidPause(sender: self)
    }

    /**
     * Resumes the timer from the current state
     */
    public func resume() {
        self.timer?.fireDate = Date()

        self.delegate?.timerDidResume(sender: self)
    }

    /**
     * Reset the timer
     */
    public func reset() {
        self.currentCounterValue = 0
        self.timer?.invalidate()
        self.elapsedTime = 0
        setNeedsDisplay()
    }
    
    /**
     * End the timer
     */
    public func end() {
        self.currentCounterValue = 0
        self.timer?.invalidate()
        
        self.delegate?.timerDidEnd(sender: self, elapsedTime: self.elapsedTime)
    }
    
    /**
     * Calculate value in minutes and seconds and return it as String
     */
    private func getMinutesAndSeconds(remainingSeconds: Int) -> String? {
        let seconds = (remainingSeconds / 3600 / 24 / 365 > 68) ? remainingSeconds * -1 : remainingSeconds
        return TimeInterval(seconds).format(using: [.minute, .hour, .day, .month, .year])
    }

    // MARK: Private methods
    
    private func addCounterLabel(){
        guard !isLabelHidden else {return}
        addSubview(counterLabel)
        let width = bounds.width / 3.5
        let originX = (bounds.width / 2) - (width / 2)
        counterLabel.frame = CGRect(x: originX, y: 0, width: width, height: bounds.height)
        
    }
    
    @objc private func timerFired(_ timer: Timer) {
        self.elapsedTime += fireInterval

        if self.elapsedTime <= self.totalTime {
            setNeedsDisplay()

            let computedCounterValue = self.beginingValue - Int(self.elapsedTime / self.interval)
            if computedCounterValue != self.currentCounterValue {
                self.currentCounterValue = computedCounterValue
            }
        } else {
            self.end()
        }
    }
}

extension TimeInterval {
    func format(using units: NSCalendar.Unit) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = .short // как отобраажется текст внутри
        formatter.zeroFormattingBehavior = .dropAll//если будет 0 не будет писаться
        return formatter.string(from: self)
    }
}
