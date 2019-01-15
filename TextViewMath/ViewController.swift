//
//  ViewController.swift
//  TextViewMath
//
//  Created by KingpiN on 24/12/18.
//  Copyright © 2018 KingpiN. All rights reserved.
//

import UIKit
import DTCoreText

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DTAttributedTextContentViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var htmlTextList: Array<String>!

    let html = """
        <HTML>
        <HEAD>
        <TITLE>Your Title Here</TITLE>
        </HEAD>
        <BODY BGCOLOR="#CC0000">
        <DIV><CENTER><p><img src="http://www.webestools.com/page/media/img_perso_dft.png" width="1000" height="1000"></p></CENTER></DIV>
        This come from string. You can insert inline formula: Hello \\(ax^2 + bx + c = 0\\) or displayed formula: $$\\sum_{i=0}^n i^2 = \\frac{(n^2+n)(1n+1)}{6}$$

        This come from string. You can insert inline formula: Hello \\(ax^2 + bx + c = 0\\) or displayed formula: $$\\sum_{i=0}^n i^2 = \\frac{(n^2+n)(1n+1)}{6}$$
        <br>

        <math xmlns='http://www.w3.org/1998/Math/MathML'><matrix><matrixrow><cn>1</cn><cn>1</cn><cn>0</cn></matrixrow><matrixrow><cn>0</cn> <cn>0</cn><cn>1</cn></matrixrow><matrixrow><cn>1</cn> <cn>0</cn> <cn>0</cn></matrixrow></matrix></math>
        <br>

        <HR>
        <a href="https://github.com/Vugla">Link Name</a>
            is a link to another nifty site
        <H1>This is a Header</H1>
        <H2>This is a Medium Header</H2>
        Send me mail at <a href="mailto:predragsamardzic13@gmail.com">
        predragsamardzic13@gmail.com</a>.
        <P> This is a new paragraph!
        <P> <B>This is a new paragraph!</B>
        <BR> <B><I>This is a new sentence without a paragraph break, in bold italics.</I></B>
        <HR>
        </BODY>
        </HTML>
    """
    
    let html2 = """
        <p><strong>Match List - I (Event) with List-II (Order of the time interval for happening of the event) and select the correct option from the options given below the lists:</strong><img src="https://res.cloudinary.com/classplus/image/upload/v1545145303/test-portal/wcvhji0azodk1o3ycyut.png"  width="600" height="600" alt="placeholder.png" /></p>↵<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>
"""
    
    let html3 = """
                <math xmlns="http://www.w3.org/1998/Math/MathML"><mover><mrow><mo>(</mo><msup><mi>a</mi><mn>2</mn></msup><mo>+</mo><msup><mi>b</mi><mn>2</mn></msup><mo>)</mo></mrow><mo>&#xAF;</mo></mover></math>"
                """
    
    let html4 = """
                <!DOCTYPE html><html><head><title>MathJax TeX Test Page</title>
                <script type="text/javascript" async
                src="MathJax-2.6.1/MathJax.js?config=TeX-AMS_CHTML"></script></head><body><div style="font-size: 30pt; color: #eee;">$$\\begin{equation}\\prod_{\\substack{1\\le i \\le n\\\\1\\le j \\le m}}M_{i,j}\\end{equation}$$</div></body></html>
                """
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100

        htmlTextList = Array<String>.init(arrayLiteral: html)
        htmlTextList.append(html)
        htmlTextList.append(html2)
        htmlTextList.append(html3)
        htmlTextList.append(html4)

        htmlTextList.append("normal text")
        htmlTextList.append("<b>bolded</b>")
        htmlTextList.append("<i>italics</i>")
        htmlTextList.append("It is possible to have both <i>italic</i> and <b>bolded</b> text! Even on multi-lines which can sometimes be <b>problematic</b>.")
        htmlTextList.append("Mixed text can also work using <b>NSAttributed String</b>, but it can be <i>slow</i> when paging thorugh the table view.")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return htmlTextList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TextViewTableViewCell") as! TextViewTableViewCell
        cell.configureOP(opData: htmlTextList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

