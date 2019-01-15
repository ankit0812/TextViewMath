import UIKit
import DTCoreText

class TextViewTableViewCell: UITableViewCell, DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate {
    
    @IBOutlet weak var contentTextView: DTAttributedTextContentView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentTextView.shouldDrawImages = false
        contentTextView.shouldDrawLinks = false
        contentTextView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    let attributedOptions: NSDictionary = [
        NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html,
        NSAttributedString.DocumentAttributeKey.characterEncoding: String.Encoding.utf8,
        DTDefaultFontFamily: "Helvetica Neue",
        DTDefaultFontSize: 17,
        DTMaxImageSize: CGSize(width:UIScreen.main.bounds.width - 40,height:UIScreen.main.bounds.width - 40)
    ]
    
    func attributedTextContentView(_ attributedTextContentView: DTAttributedTextContentView!, viewFor attachment: DTTextAttachment!, frame: CGRect) -> UIView! {
        if attachment is DTImageTextAttachment {
            let currentAttachment: DTImageTextAttachment = attachment as! DTImageTextAttachment
            let imageView = DTLazyImageView(frame: frame)
            imageView.delegate = self
            imageView.image = currentAttachment.image
            imageView.url = attachment.contentURL
            imageView.shouldShowProgressiveDownload = true
            return imageView
        }
        return nil
    }
    
    func lazyImageView(_ lazyImageView: DTLazyImageView!, didChangeImageSize size: CGSize) {
        let url = lazyImageView.url
        let pred = NSPredicate(format: "contentURL == %@",url! as CVarArg)
        
        let array = self.contentTextView.layoutFrame.textAttachments(with: pred)
        
        for _ in (array?.enumerated())! {
            let element = DTTextAttachment()
            element.originalSize = size
            element.displaySize = size
        }
        DispatchQueue.main.async {
            self.contentTextView.layouter = nil
            self.contentTextView.relayoutText()
        }
    }
    
    func configureOP(opData: String) {
        let contentData = opData.data(using: .utf8)
        let contentAttr = NSAttributedString.init(htmlData: contentData, options: attributedOptions as? [AnyHashable : Any], documentAttributes: nil)
        //print(contentAttr)
        contentTextView.attributedString = contentAttr
    }
}
