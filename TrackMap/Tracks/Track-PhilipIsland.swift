//
//  Track-PhilipIsland.swift
//  TrackMap
//
//  Created by Jack Perry on 23/12/2022.
//

import Foundation
import UIKit

protocol Track {

    var size: CGSize { get }
    var track: UIBezierPath { get }
    var pitLane: [UIBezierPath] { get }
    var trackSections: [UIBezierPath] { get }
    var sand: [UIBezierPath] { get }
    var runoffAreas: [UIBezierPath] { get }

}


struct PhilipIslandTrack: Track {

    var size: CGSize {
        CGSize(width: 596, height: 447)
    }

    var pitLane: [UIBezierPath] = {
        let pitLanePath = UIBezierPath()
        pitLanePath.move(to: CGPoint(x: 55.2, y: 69.9))
        pitLanePath.addCurve(to: CGPoint(x: 88.4, y: 54.7), controlPoint1: CGPoint(x: 55.2, y: 69.9), controlPoint2: CGPoint(x: 73.8, y: 56.4))
        pitLanePath.addCurve(to: CGPoint(x: 150.1, y: 62.3), controlPoint1: CGPoint(x: 103.1, y: 53), controlPoint2: CGPoint(x: 139.4, y: 59.6))
        pitLanePath.addCurve(to: CGPoint(x: 182.4, y: 88), controlPoint1: CGPoint(x: 160.8, y: 65), controlPoint2: CGPoint(x: 171.8, y: 75.4))
        pitLanePath.addCurve(to: CGPoint(x: 257.4, y: 175.3), controlPoint1: CGPoint(x: 193.1, y: 100.7), controlPoint2: CGPoint(x: 257.4, y: 175.3))
        pitLanePath.addLine(to: CGPoint(x: 311.4, y: 235.7))
        pitLanePath.addCurve(to: CGPoint(x: 368.4, y: 298.3), controlPoint1: CGPoint(x: 311.4, y: 235.7), controlPoint2: CGPoint(x: 353.5, y: 283.4))
        pitLanePath.addCurve(to: CGPoint(x: 381.2, y: 305.8), controlPoint1: CGPoint(x: 371, y: 300.9), controlPoint2: CGPoint(x: 374.4, y: 302.6))
        pitLanePath.lineWidth = 2
        pitLanePath.stroke()

        return [pitLanePath]
    }()

    var trackSections: [UIBezierPath] = {
        let t1Path = UIBezierPath()
        t1Path.move(to: CGPoint(x: 202.1, y: 100.6))
        t1Path.addCurve(to: CGPoint(x: 264, y: 173.8), controlPoint1: CGPoint(x: 228.1, y: 131.4), controlPoint2: CGPoint(x: 264, y: 173.8))
        t1Path.lineWidth = 8
        t1Path.stroke()

        let t2Path = UIBezierPath()
        t2Path.move(to: CGPoint(x: 63.5, y: 202.8))
        t2Path.addCurve(to: CGPoint(x: 85.2, y: 179.4), controlPoint1: CGPoint(x: 71.5, y: 193.5), controlPoint2: CGPoint(x: 80, y: 185.7))
        t2Path.addCurve(to: CGPoint(x: 70.9, y: 162.4), controlPoint1: CGPoint(x: 88.7, y: 175.1), controlPoint2: CGPoint(x: 90.8, y: 163))
        t2Path.addCurve(to: CGPoint(x: 27.8, y: 121), controlPoint1: CGPoint(x: 46.2, y: 161.6), controlPoint2: CGPoint(x: 25.5, y: 158.9))
        t2Path.addCurve(to: CGPoint(x: 40.3, y: 89.3), controlPoint1: CGPoint(x: 28.4, y: 111.4), controlPoint2: CGPoint(x: 36.1, y: 96.1))
        t2Path.addCurve(to: CGPoint(x: 69.9, y: 52.3), controlPoint1: CGPoint(x: 55.2, y: 65.2), controlPoint2: CGPoint(x: 66.7, y: 55.7))
        t2Path.addCurve(to: CGPoint(x: 137.6, y: 40), controlPoint1: CGPoint(x: 75.4, y: 46.6), controlPoint2: CGPoint(x: 101.9, y: 23.5))
        t2Path.addCurve(to: CGPoint(x: 175.7, y: 69.5), controlPoint1: CGPoint(x: 156.2, y: 48.6), controlPoint2: CGPoint(x: 173.2, y: 66.3))
        t2Path.addCurve(to: CGPoint(x: 202, y: 100.7), controlPoint1: CGPoint(x: 176.6, y: 70.6), controlPoint2: CGPoint(x: 187.8, y: 83.9))
        t2Path.lineWidth = 8
        t2Path.stroke()

        let t3Path = UIBezierPath()
        t3Path.move(to: CGPoint(x: 276, y: 415.2))
        t3Path.addCurve(to: CGPoint(x: 242.1, y: 395.3), controlPoint1: CGPoint(x: 261.5, y: 408), controlPoint2: CGPoint(x: 255, y: 403.1))
        t3Path.addCurve(to: CGPoint(x: 212.9, y: 364.7), controlPoint1: CGPoint(x: 233, y: 389.8), controlPoint2: CGPoint(x: 221.8, y: 377.7))
        t3Path.addCurve(to: CGPoint(x: 185, y: 326.7), controlPoint1: CGPoint(x: 203.2, y: 350.4), controlPoint2: CGPoint(x: 192.9, y: 336.7))
        t3Path.addCurve(to: CGPoint(x: 144.5, y: 306.1), controlPoint1: CGPoint(x: 178.6, y: 318.6), controlPoint2: CGPoint(x: 162.7, y: 308.8))
        t3Path.addCurve(to: CGPoint(x: 83.6, y: 297.6), controlPoint1: CGPoint(x: 115.9, y: 301.7), controlPoint2: CGPoint(x: 93.8, y: 299.7))
        t3Path.addCurve(to: CGPoint(x: 41.6, y: 245.4), controlPoint1: CGPoint(x: 69.1, y: 294.6), controlPoint2: CGPoint(x: 35.7, y: 276.7))
        t3Path.addCurve(to: CGPoint(x: 58.7, y: 208.7), controlPoint1: CGPoint(x: 45.5, y: 224.9), controlPoint2: CGPoint(x: 50.1, y: 219.9))
        t3Path.addCurve(to: CGPoint(x: 63.5, y: 202.8), controlPoint1: CGPoint(x: 60.3, y: 206.7), controlPoint2: CGPoint(x: 61.9, y: 204.7))
        t3Path.lineWidth = 8
        t3Path.stroke()

        let t4Path = UIBezierPath()
        t4Path.move(to: CGPoint(x: 304.8, y: 372.9))
        t4Path.addCurve(to: CGPoint(x: 319.3, y: 392.8), controlPoint1: CGPoint(x: 309.7, y: 378.8), controlPoint2: CGPoint(x: 315.1, y: 385.5))
        t4Path.addCurve(to: CGPoint(x: 316.3, y: 416.1), controlPoint1: CGPoint(x: 321.8, y: 397.1), controlPoint2: CGPoint(x: 326.9, y: 405.5))
        t4Path.addCurve(to: CGPoint(x: 282.3, y: 418.3), controlPoint1: CGPoint(x: 308, y: 424.4), controlPoint2: CGPoint(x: 299.5, y: 426.4))
        t4Path.addCurve(to: CGPoint(x: 276, y: 415.2), controlPoint1: CGPoint(x: 280, y: 417.2), controlPoint2: CGPoint(x: 277.9, y: 416.2))
        t4Path.lineWidth = 8
        t4Path.stroke()

        let t5Path = UIBezierPath()
        t5Path.move(to: CGPoint(x: 539, y: 364.4))
        t5Path.addCurve(to: CGPoint(x: 453.7, y: 385.7), controlPoint1: CGPoint(x: 516.7, y: 370.8), controlPoint2: CGPoint(x: 476.2, y: 381.4))
        t5Path.addCurve(to: CGPoint(x: 392, y: 384.8), controlPoint1: CGPoint(x: 440.7, y: 388.2), controlPoint2: CGPoint(x: 418.6, y: 394.4))
        t5Path.addCurve(to: CGPoint(x: 346.9, y: 359.1), controlPoint1: CGPoint(x: 368, y: 376.1), controlPoint2: CGPoint(x: 359.1, y: 369.1))
        t5Path.addCurve(to: CGPoint(x: 301.5, y: 317.6), controlPoint1: CGPoint(x: 335.7, y: 349.9), controlPoint2: CGPoint(x: 313, y: 327.3))
        t5Path.addCurve(to: CGPoint(x: 288.2, y: 311.3), controlPoint1: CGPoint(x: 298.1, y: 314.8), controlPoint2: CGPoint(x: 294.1, y: 311.4))
        t5Path.addCurve(to: CGPoint(x: 277.8, y: 326.4), controlPoint1: CGPoint(x: 281.6, y: 311.3), controlPoint2: CGPoint(x: 277.5, y: 317.1))
        t5Path.addCurve(to: CGPoint(x: 296.2, y: 362), controlPoint1: CGPoint(x: 278, y: 335.9), controlPoint2: CGPoint(x: 291.9, y: 355.8))
        t5Path.addCurve(to: CGPoint(x: 304.9, y: 372.9), controlPoint1: CGPoint(x: 298.5, y: 365.2), controlPoint2: CGPoint(x: 301.5, y: 368.9))
        t5Path.lineWidth = 8
        t5Path.stroke()

        let t6Path = UIBezierPath()
        t6Path.move(to: CGPoint(x: 319, y: 234.7))
        t6Path.addLine(to: CGPoint(x: 385.7, y: 308.4))
        t6Path.addCurve(to: CGPoint(x: 465.8, y: 323.5), controlPoint1: CGPoint(x: 385.7, y: 308.4), controlPoint2: CGPoint(x: 422.4, y: 344.9))
        t6Path.addCurve(to: CGPoint(x: 518.6, y: 296.1), controlPoint1: CGPoint(x: 515.9, y: 298.7), controlPoint2: CGPoint(x: 497.2, y: 306.4))
        t6Path.addCurve(to: CGPoint(x: 570.8, y: 312.5), controlPoint1: CGPoint(x: 537, y: 287.3), controlPoint2: CGPoint(x: 560.6, y: 292.2))
        t6Path.addCurve(to: CGPoint(x: 549.9, y: 361.2), controlPoint1: CGPoint(x: 581.7, y: 334.1), controlPoint2: CGPoint(x: 569.7, y: 355))
        t6Path.addCurve(to: CGPoint(x: 538.9, y: 364.5), controlPoint1: CGPoint(x: 547.2, y: 362), controlPoint2: CGPoint(x: 543.4, y: 363.2))
        t6Path.lineWidth = 8
        t6Path.stroke()

        let t7Path = UIBezierPath()
        t7Path.move(to: CGPoint(x: 264, y: 173.8))
        t7Path.addCurve(to: CGPoint(x: 319.1, y: 234.7), controlPoint1: CGPoint(x: 277.7, y: 189.2), controlPoint2: CGPoint(x: 319.1, y: 234.7))
        t7Path.lineWidth = 8
        t7Path.stroke()

        return [t1Path, t2Path, t3Path, t4Path, t5Path, t6Path, t7Path]
    }()

    var sand: [UIBezierPath] = {
        let sand1Path = UIBezierPath()
        sand1Path.move(to: CGPoint(x: 320.9, y: 387.8))
        sand1Path.addCurve(to: CGPoint(x: 332.3, y: 405.2), controlPoint1: CGPoint(x: 320.9, y: 387.8), controlPoint2: CGPoint(x: 328.9, y: 397.1))
        sand1Path.addCurve(to: CGPoint(x: 322.3, y: 430.2), controlPoint1: CGPoint(x: 335.7, y: 413.3), controlPoint2: CGPoint(x: 329.3, y: 425.3))
        sand1Path.addCurve(to: CGPoint(x: 295.3, y: 432), controlPoint1: CGPoint(x: 315.3, y: 435.1), controlPoint2: CGPoint(x: 302.9, y: 433.2))
        sand1Path.addCurve(to: CGPoint(x: 253.2, y: 409.7), controlPoint1: CGPoint(x: 287.7, y: 430.8), controlPoint2: CGPoint(x: 255.5, y: 411.4))
        sand1Path.addCurve(to: CGPoint(x: 247.6, y: 402.4), controlPoint1: CGPoint(x: 250.9, y: 408), controlPoint2: CGPoint(x: 247.6, y: 402.4))
        sand1Path.addLine(to: CGPoint(x: 271.7, y: 413.8))
        sand1Path.addLine(to: CGPoint(x: 298.7, y: 423.4))
        sand1Path.addLine(to: CGPoint(x: 317.1, y: 417.2))
        sand1Path.addLine(to: CGPoint(x: 322.6, y: 405.2))
        sand1Path.addLine(to: CGPoint(x: 320.9, y: 387.8))
        sand1Path.close()
        sand1Path.fill()

        let sand2Path = UIBezierPath()
        sand2Path.move(to: CGPoint(x: 415.3, y: 393.6))
        sand2Path.addCurve(to: CGPoint(x: 396.3, y: 403.2), controlPoint1: CGPoint(x: 415.3, y: 393.6), controlPoint2: CGPoint(x: 404.8, y: 400.6))
        sand2Path.addCurve(to: CGPoint(x: 380.3, y: 405.1), controlPoint1: CGPoint(x: 390.9, y: 404.9), controlPoint2: CGPoint(x: 384, y: 406.7))
        sand2Path.addCurve(to: CGPoint(x: 331.9, y: 373.2), controlPoint1: CGPoint(x: 376.6, y: 403.5), controlPoint2: CGPoint(x: 331.9, y: 373.2))
        sand2Path.addCurve(to: CGPoint(x: 313.5, y: 356.4), controlPoint1: CGPoint(x: 331.9, y: 373.2), controlPoint2: CGPoint(x: 319.8, y: 365.6))
        sand2Path.addCurve(to: CGPoint(x: 301.3, y: 336.8), controlPoint1: CGPoint(x: 307.2, y: 347.2), controlPoint2: CGPoint(x: 302.3, y: 341))
        sand2Path.addCurve(to: CGPoint(x: 299.4, y: 318.9), controlPoint1: CGPoint(x: 300.3, y: 332.5), controlPoint2: CGPoint(x: 299.4, y: 318.9))
        sand2Path.addLine(to: CGPoint(x: 331.5, y: 347.2))
        sand2Path.addLine(to: CGPoint(x: 366.6, y: 373.4))
        sand2Path.addLine(to: CGPoint(x: 398.4, y: 387.8))
        sand2Path.addLine(to: CGPoint(x: 415.3, y: 393.6))
        sand2Path.close()
        sand2Path.fill()


        //// sand3 Drawing
        let sand3Path = UIBezierPath()
        sand3Path.move(to: CGPoint(x: 403.1, y: 331.8))
        sand3Path.addLine(to: CGPoint(x: 431.4, y: 363.3))
        sand3Path.addCurve(to: CGPoint(x: 451, y: 361.3), controlPoint1: CGPoint(x: 431.4, y: 363.3), controlPoint2: CGPoint(x: 446.2, y: 362.8))
        sand3Path.addCurve(to: CGPoint(x: 478.5, y: 341.5), controlPoint1: CGPoint(x: 455.8, y: 359.8), controlPoint2: CGPoint(x: 473.4, y: 346.3))
        sand3Path.addCurve(to: CGPoint(x: 483.4, y: 336.9), controlPoint1: CGPoint(x: 484, y: 336.4), controlPoint2: CGPoint(x: 483.4, y: 336.9))
        sand3Path.addLine(to: CGPoint(x: 477.6, y: 326.9))
        sand3Path.addLine(to: CGPoint(x: 446, y: 337.3))
        sand3Path.addLine(to: CGPoint(x: 412.9, y: 333.8))
        sand3Path.addLine(to: CGPoint(x: 403.1, y: 331.8))
        sand3Path.close()
        sand3Path.fill()

        let sand4Path = UIBezierPath()
        sand4Path.move(to: CGPoint(x: 508.9, y: 375.8))
        sand4Path.addLine(to: CGPoint(x: 488.1, y: 381.6))
        sand4Path.addCurve(to: CGPoint(x: 568.9, y: 370.8), controlPoint1: CGPoint(x: 488.1, y: 381.6), controlPoint2: CGPoint(x: 553.9, y: 383))
        sand4Path.addCurve(to: CGPoint(x: 589.8, y: 323), controlPoint1: CGPoint(x: 592.3, y: 351.8), controlPoint2: CGPoint(x: 591.6, y: 346.3))
        sand4Path.addCurve(to: CGPoint(x: 579.1, y: 292.7), controlPoint1: CGPoint(x: 588, y: 299.7), controlPoint2: CGPoint(x: 583.7, y: 297.5))
        sand4Path.addCurve(to: CGPoint(x: 561.8, y: 280), controlPoint1: CGPoint(x: 573.4, y: 286.7), controlPoint2: CGPoint(x: 566.6, y: 280.6))
        sand4Path.addCurve(to: CGPoint(x: 531.1, y: 288.1), controlPoint1: CGPoint(x: 552.4, y: 278.9), controlPoint2: CGPoint(x: 531.1, y: 288.1))
        sand4Path.addCurve(to: CGPoint(x: 574.9, y: 318.9), controlPoint1: CGPoint(x: 531.1, y: 288.1), controlPoint2: CGPoint(x: 572.9, y: 291.5))
        sand4Path.addCurve(to: CGPoint(x: 558, y: 361), controlPoint1: CGPoint(x: 576.8, y: 344.6), controlPoint2: CGPoint(x: 561, y: 359.2))
        sand4Path.addCurve(to: CGPoint(x: 508.9, y: 375.8), controlPoint1: CGPoint(x: 555, y: 362.8), controlPoint2: CGPoint(x: 508.9, y: 375.8))
        sand4Path.close()
        sand4Path.fill()

        let sand6Path = UIBezierPath()
        sand6Path.move(to: CGPoint(x: 71.1, y: 295.6))
        sand6Path.addLine(to: CGPoint(x: 60.3, y: 298.6))
        sand6Path.addCurve(to: CGPoint(x: 43.5, y: 294.3), controlPoint1: CGPoint(x: 60.3, y: 298.6), controlPoint2: CGPoint(x: 47.6, y: 295.8))
        sand6Path.addCurve(to: CGPoint(x: 25.5, y: 283.8), controlPoint1: CGPoint(x: 38.6, y: 292.6), controlPoint2: CGPoint(x: 28.6, y: 287.4))
        sand6Path.addCurve(to: CGPoint(x: 24.5, y: 252.3), controlPoint1: CGPoint(x: 21.2, y: 278.9), controlPoint2: CGPoint(x: 22, y: 273.8))
        sand6Path.addCurve(to: CGPoint(x: 36.5, y: 216), controlPoint1: CGPoint(x: 27.1, y: 230), controlPoint2: CGPoint(x: 36.5, y: 216))
        sand6Path.addLine(to: CGPoint(x: 58.6, y: 208.7))
        sand6Path.addLine(to: CGPoint(x: 39.3, y: 249.3))
        sand6Path.addLine(to: CGPoint(x: 46.9, y: 276.1))
        sand6Path.addLine(to: CGPoint(x: 71.1, y: 295.6))
        sand6Path.close()
        sand6Path.fill()

        let sand7Path = UIBezierPath()
        sand7Path.move(to: CGPoint(x: 31.6, y: 153.7))
        sand7Path.addLine(to: CGPoint(x: 16.1, y: 139.8))
        sand7Path.addCurve(to: CGPoint(x: 14.8, y: 113.4), controlPoint1: CGPoint(x: 16.1, y: 139.8), controlPoint2: CGPoint(x: 11.8, y: 126.1))
        sand7Path.addCurve(to: CGPoint(x: 48.5, y: 55.4), controlPoint1: CGPoint(x: 17.8, y: 100.7), controlPoint2: CGPoint(x: 28.7, y: 80.6))
        sand7Path.addCurve(to: CGPoint(x: 80.4, y: 23.6), controlPoint1: CGPoint(x: 68.3, y: 30.2), controlPoint2: CGPoint(x: 76.3, y: 25.3))
        sand7Path.addCurve(to: CGPoint(x: 125.8, y: 18.6), controlPoint1: CGPoint(x: 92, y: 18.7), controlPoint2: CGPoint(x: 100.2, y: 17.3))
        sand7Path.addCurve(to: CGPoint(x: 165.2, y: 35.4), controlPoint1: CGPoint(x: 139.1, y: 19.2), controlPoint2: CGPoint(x: 147.4, y: 23.2))
        sand7Path.addCurve(to: CGPoint(x: 206.7, y: 89.3), controlPoint1: CGPoint(x: 187.5, y: 50.7), controlPoint2: CGPoint(x: 206.7, y: 89.3))
        sand7Path.addLine(to: CGPoint(x: 208.9, y: 105.4))
        sand7Path.addLine(to: CGPoint(x: 154.6, y: 50.1))
        sand7Path.addCurve(to: CGPoint(x: 124.2, y: 34.1), controlPoint1: CGPoint(x: 154.6, y: 50.1), controlPoint2: CGPoint(x: 131.8, y: 33.9))
        sand7Path.addCurve(to: CGPoint(x: 81.7, y: 43.1), controlPoint1: CGPoint(x: 116.6, y: 34.3), controlPoint2: CGPoint(x: 87.9, y: 35.8))
        sand7Path.addCurve(to: CGPoint(x: 41.7, y: 87.2), controlPoint1: CGPoint(x: 75.5, y: 50.4), controlPoint2: CGPoint(x: 44, y: 79.3))
        sand7Path.addCurve(to: CGPoint(x: 27.7, y: 125.6), controlPoint1: CGPoint(x: 39.4, y: 95.1), controlPoint2: CGPoint(x: 26, y: 116.4))
        sand7Path.addCurve(to: CGPoint(x: 31.6, y: 153.7), controlPoint1: CGPoint(x: 29.4, y: 134.8), controlPoint2: CGPoint(x: 31.6, y: 153.7))
        sand7Path.close()
        sand7Path.fill()

        return [sand1Path, sand2Path, sand3Path, sand4Path, sand6Path, sand7Path]
    }()

    var runoffAreas: [UIBezierPath] = {
        let asphalt1Path = UIBezierPath()
        asphalt1Path.move(to: CGPoint(x: 299.4, y: 310.9))
        asphalt1Path.addCurve(to: CGPoint(x: 285.8, y: 303), controlPoint1: CGPoint(x: 299.4, y: 310.9), controlPoint2: CGPoint(x: 289.9, y: 303.3))
        asphalt1Path.addCurve(to: CGPoint(x: 270.8, y: 314.8), controlPoint1: CGPoint(x: 281.6, y: 302.7), controlPoint2: CGPoint(x: 272, y: 307.8))
        asphalt1Path.addCurve(to: CGPoint(x: 274.6, y: 331.3), controlPoint1: CGPoint(x: 269.6, y: 321.8), controlPoint2: CGPoint(x: 273.1, y: 326.8))
        asphalt1Path.addCurve(to: CGPoint(x: 277.2, y: 323.5), controlPoint1: CGPoint(x: 276.1, y: 335.8), controlPoint2: CGPoint(x: 276.5, y: 324.8))
        asphalt1Path.addCurve(to: CGPoint(x: 283.2, y: 312.6), controlPoint1: CGPoint(x: 277.9, y: 322.2), controlPoint2: CGPoint(x: 277.1, y: 314.5))
        asphalt1Path.addCurve(to: CGPoint(x: 299.4, y: 310.9), controlPoint1: CGPoint(x: 289.3, y: 310.7), controlPoint2: CGPoint(x: 299.4, y: 310.9))
        asphalt1Path.close()
        asphalt1Path.fill()

        let asphalt2Path = UIBezierPath()
        asphalt2Path.move(to: CGPoint(x: 387.1, y: 314.8))
        asphalt2Path.addLine(to: CGPoint(x: 403.1, y: 331.8))
        asphalt2Path.addCurve(to: CGPoint(x: 437, y: 340.2), controlPoint1: CGPoint(x: 403.1, y: 331.8), controlPoint2: CGPoint(x: 421.6, y: 340.7))
        asphalt2Path.addCurve(to: CGPoint(x: 478.5, y: 328.7), controlPoint1: CGPoint(x: 462.4, y: 339.3), controlPoint2: CGPoint(x: 478.5, y: 328.7))
        asphalt2Path.addLine(to: CGPoint(x: 475.2, y: 322.3))
        asphalt2Path.addLine(to: CGPoint(x: 444.9, y: 330.8))
        asphalt2Path.addCurve(to: CGPoint(x: 405.5, y: 323.4), controlPoint1: CGPoint(x: 444.9, y: 330.8), controlPoint2: CGPoint(x: 417.1, y: 330.7))
        asphalt2Path.addCurve(to: CGPoint(x: 387.1, y: 314.8), controlPoint1: CGPoint(x: 393.9, y: 316.1), controlPoint2: CGPoint(x: 387.1, y: 314.8))
        asphalt2Path.close()
        asphalt2Path.fill()

        return [asphalt1Path, asphalt2Path]
    }()

    var track: UIBezierPath = {
        let trackPath = UIBezierPath()
        trackPath.move(to: CGPoint(x: 188.1, y: 82.6))
        trackPath.addCurve(to: CGPoint(x: 250, y: 155.8), controlPoint1: CGPoint(x: 214.1, y: 113.4), controlPoint2: CGPoint(x: 250, y: 155.8))
        trackPath.move(to: CGPoint(x: 49.5, y: 184.8))
        trackPath.addCurve(to: CGPoint(x: 71.2, y: 161.4), controlPoint1: CGPoint(x: 57.5, y: 175.5), controlPoint2: CGPoint(x: 66, y: 167.7))
        trackPath.addCurve(to: CGPoint(x: 56.9, y: 144.4), controlPoint1: CGPoint(x: 74.7, y: 157.1), controlPoint2: CGPoint(x: 76.8, y: 145))
        trackPath.addCurve(to: CGPoint(x: 13.8, y: 103), controlPoint1: CGPoint(x: 32.2, y: 143.6), controlPoint2: CGPoint(x: 11.5, y: 140.9))
        trackPath.addCurve(to: CGPoint(x: 26.3, y: 71.3), controlPoint1: CGPoint(x: 14.4, y: 93.4), controlPoint2: CGPoint(x: 22.1, y: 78.1))
        trackPath.addCurve(to: CGPoint(x: 55.9, y: 34.3), controlPoint1: CGPoint(x: 41.2, y: 47.2), controlPoint2: CGPoint(x: 52.7, y: 37.7))
        trackPath.addCurve(to: CGPoint(x: 123.6, y: 22), controlPoint1: CGPoint(x: 61.4, y: 28.6), controlPoint2: CGPoint(x: 87.9, y: 5.5))
        trackPath.addCurve(to: CGPoint(x: 161.7, y: 51.5), controlPoint1: CGPoint(x: 142.2, y: 30.6), controlPoint2: CGPoint(x: 159.2, y: 48.3))
        trackPath.addCurve(to: CGPoint(x: 188, y: 82.7), controlPoint1: CGPoint(x: 162.6, y: 52.6), controlPoint2: CGPoint(x: 173.8, y: 65.9))
        trackPath.move(to: CGPoint(x: 262, y: 397.2))
        trackPath.addCurve(to: CGPoint(x: 228.1, y: 377.3), controlPoint1: CGPoint(x: 247.5, y: 390), controlPoint2: CGPoint(x: 241, y: 385.1))
        trackPath.addCurve(to: CGPoint(x: 198.9, y: 346.7), controlPoint1: CGPoint(x: 219, y: 371.8), controlPoint2: CGPoint(x: 207.8, y: 359.7))
        trackPath.addCurve(to: CGPoint(x: 171, y: 308.7), controlPoint1: CGPoint(x: 189.2, y: 332.4), controlPoint2: CGPoint(x: 178.9, y: 318.7))
        trackPath.addCurve(to: CGPoint(x: 130.5, y: 288.1), controlPoint1: CGPoint(x: 164.6, y: 300.6), controlPoint2: CGPoint(x: 148.7, y: 290.8))
        trackPath.addCurve(to: CGPoint(x: 69.6, y: 279.6), controlPoint1: CGPoint(x: 101.9, y: 283.7), controlPoint2: CGPoint(x: 79.8, y: 281.7))
        trackPath.addCurve(to: CGPoint(x: 27.6, y: 227.4), controlPoint1: CGPoint(x: 55.1, y: 276.6), controlPoint2: CGPoint(x: 21.7, y: 258.7))
        trackPath.addCurve(to: CGPoint(x: 44.7, y: 190.7), controlPoint1: CGPoint(x: 31.5, y: 206.9), controlPoint2: CGPoint(x: 36.1, y: 201.9))
        trackPath.addCurve(to: CGPoint(x: 49.5, y: 184.8), controlPoint1: CGPoint(x: 46.3, y: 188.7), controlPoint2: CGPoint(x: 47.9, y: 186.7))
        trackPath.move(to: CGPoint(x: 290.8, y: 354.9))
        trackPath.addCurve(to: CGPoint(x: 305.3, y: 374.8), controlPoint1: CGPoint(x: 295.7, y: 360.8), controlPoint2: CGPoint(x: 301.1, y: 367.5))
        trackPath.addCurve(to: CGPoint(x: 302.3, y: 398.1), controlPoint1: CGPoint(x: 307.8, y: 379.1), controlPoint2: CGPoint(x: 312.9, y: 387.5))
        trackPath.addCurve(to: CGPoint(x: 268.3, y: 400.3), controlPoint1: CGPoint(x: 294, y: 406.4), controlPoint2: CGPoint(x: 285.5, y: 408.4))
        trackPath.addCurve(to: CGPoint(x: 262, y: 397.2), controlPoint1: CGPoint(x: 266, y: 399.2), controlPoint2: CGPoint(x: 263.9, y: 398.2))
        trackPath.move(to: CGPoint(x: 525, y: 346.4))
        trackPath.addCurve(to: CGPoint(x: 439.7, y: 367.7), controlPoint1: CGPoint(x: 502.7, y: 352.8), controlPoint2: CGPoint(x: 462.2, y: 363.4))
        trackPath.addCurve(to: CGPoint(x: 378, y: 366.8), controlPoint1: CGPoint(x: 426.7, y: 370.2), controlPoint2: CGPoint(x: 404.6, y: 376.4))
        trackPath.addCurve(to: CGPoint(x: 332.9, y: 341.1), controlPoint1: CGPoint(x: 354, y: 358.1), controlPoint2: CGPoint(x: 345.1, y: 351.1))
        trackPath.addCurve(to: CGPoint(x: 287.5, y: 299.6), controlPoint1: CGPoint(x: 321.7, y: 331.9), controlPoint2: CGPoint(x: 299, y: 309.3))
        trackPath.addCurve(to: CGPoint(x: 274.2, y: 293.3), controlPoint1: CGPoint(x: 284.1, y: 296.8), controlPoint2: CGPoint(x: 280.1, y: 293.4))
        trackPath.addCurve(to: CGPoint(x: 263.8, y: 308.4), controlPoint1: CGPoint(x: 267.6, y: 293.3), controlPoint2: CGPoint(x: 263.5, y: 299.1))
        trackPath.addCurve(to: CGPoint(x: 282.2, y: 344), controlPoint1: CGPoint(x: 264, y: 317.9), controlPoint2: CGPoint(x: 277.9, y: 337.8))
        trackPath.addCurve(to: CGPoint(x: 290.9, y: 354.9), controlPoint1: CGPoint(x: 284.5, y: 347.2), controlPoint2: CGPoint(x: 287.5, y: 350.9))
        trackPath.move(to: CGPoint(x: 305, y: 216.7))
        trackPath.addLine(to: CGPoint(x: 371.7, y: 290.4))
        trackPath.addCurve(to: CGPoint(x: 451.8, y: 305.5), controlPoint1: CGPoint(x: 371.7, y: 290.4), controlPoint2: CGPoint(x: 408.4, y: 326.9))
        trackPath.addCurve(to: CGPoint(x: 504.6, y: 278.1), controlPoint1: CGPoint(x: 501.9, y: 280.7), controlPoint2: CGPoint(x: 483.2, y: 288.4))
        trackPath.addCurve(to: CGPoint(x: 556.8, y: 294.5), controlPoint1: CGPoint(x: 523, y: 269.3), controlPoint2: CGPoint(x: 546.6, y: 274.2))
        trackPath.addCurve(to: CGPoint(x: 535.9, y: 343.2), controlPoint1: CGPoint(x: 567.7, y: 316.1), controlPoint2: CGPoint(x: 555.7, y: 337))
        trackPath.addCurve(to: CGPoint(x: 524.9, y: 346.5), controlPoint1: CGPoint(x: 533.2, y: 344), controlPoint2: CGPoint(x: 529.4, y: 345.2))
        trackPath.move(to: CGPoint(x: 250, y: 155.8))
        trackPath.addCurve(to: CGPoint(x: 305.1, y: 216.7), controlPoint1: CGPoint(x: 263.7, y: 171.2), controlPoint2: CGPoint(x: 305.1, y: 216.7))
//        trackPath.move(to: CGPoint(x: 188.1, y: 82.6))
        trackPath.lineWidth = 8
        trackPath.stroke()


        return trackPath
    }()

}
