
import UIKit

class StartInfoViewController: UIViewController, UIScrollViewDelegate
{
    var pageViewController : UIPageViewController?
    var pageTitles : Array<String> = ["Matching!", "Challenges!", "New Friends!"]
    var infos : Array<String> = ["Met jouw info zoeken we je perfecte makker!", "Leer elkaar kennen tijden de challenges", "Start alleen en eindig met 3 nieuwe makkers!"]
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    
    //var pageImages : Array<String> = ["startPeople", "startPeople", "startPeople"]
    var currentIndex : Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
  
        let bg = UIImage(named: "BG")
        let bgview = UIImageView(image: bg)
        self.view.addSubview(bgview)
        
        let header = UIImage(named: "header")
        let headerview = UIImageView(image: header)
        headerview.frame = CGRectMake(-10, 25, header!.size.width, header!.size.height)
        self.view.addSubview(headerview)
        
        let people = UIImage(named:"startPeople")
        let pview = UIImageView(image: people)
        pview.frame = CGRectMake(0, 125, people!.size.width, people!.size.height)
        self.view.addSubview(pview)
        
        let topk = UIImage(named: "kader-bottom")
        let topkview = UIImageView(image: topk)
        topkview.frame = CGRectMake(20, 390, topk!.size.width, topk!.size.height)
        self.view.addSubview(topkview)
        
        var button = pageButton(theViewC: self, titel: "Start!", targetfunction: "next")
        
        self.scrollViewtje()
        
  
    

    }
    
    func scrollViewtje(){
        
        var xPos = CGFloat(0);
        self.scrollView = UIScrollView(frame: CGRectMake(0, 300, 320, 220))
        self.scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height)
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true;
        self.scrollView.bounces = true;
        self.scrollView.showsHorizontalScrollIndicator = false
        self.pageControl = UIPageControl(frame:CGRectMake(0, 470, self.scrollView.frame.size.width, 20))
        self.pageControl.numberOfPages = Int(self.scrollView.contentSize.width / self.scrollView.frame.size.width)
        self.pageControl.addTarget(self, action: Selector("changePage:"), forControlEvents: UIControlEvents.ValueChanged)
        
        self.pageControl.pageIndicatorTintColor = UIColor(red: 242/225, green: 133/225, blue: 141/225, alpha: 1)
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 65/225, green: 111/225, blue: 164/225, alpha: 1)
        self.view.addSubview(self.pageControl)
        
        for (index, img) in enumerate(self.pageTitles) {
            
            let image = UIImage(named: pageTitles[Int(index)])
     
            let head = UIImage(named: "pinkBg")
            let headv = UIImageView(image: head)
            headv.frame = CGRectMake(xPos+10, 5, head!.size.width, head!.size.height)
            
            self.scrollView.addSubview(headv)
            
            
            let labelnr = UILabel(frame: CGRectMake(45+xPos, 15, view.frame.width, 50))
            labelnr.textColor = UIColor.whiteColor()
            labelnr.text = String(index+1)
            labelnr.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 30)
            
            self.scrollView.addSubview(labelnr)
            
            
            let label = UILabel(frame: CGRectMake(90+xPos, 15, view.frame.width, 50))
            label.textColor = UIColor.whiteColor()
            label.text = pageTitles[index]
            
            label.font = UIFont(name: "AvenirNext-MediumItalic", size: 30)
            
            //label.textAlignment = .Center
            self.scrollView.addSubview(label)

            
            
            let font = UIFont(name: "AvenirNext-MediumItalic", size: 20)
            
            let infostring = infos[Int(index)] as NSString
            let boundingBox = infostring.boundingRectWithSize(CGSizeMake(230,
                CGFloat.max), options:
                NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:
                [NSFontAttributeName:font!], context: nil)
            
            let info = UILabel(frame: CGRectMake(50+xPos, 85,
                    boundingBox.size.width, boundingBox.size.height))
            info.text = infos[index]
            info.textColor = UIColor(red: 242/225, green: 133/225, blue: 141/225, alpha: 1)
            //println(info.text)
            //info.sizeToFit()
            info.font =  UIFont(name: "AvenirNext-MediumItalic", size: 20)
            
            info.numberOfLines = 0
            self.scrollView.addSubview(info)
            
            xPos += CGFloat(UIScreen.mainScreen().bounds.width)
            //println(xPos)
            
            
            
            
        }
        
        
        //scrollView.backgroundColor = UIColor.redColor()
        self.view.addSubview(scrollView)
        
        
    }
    
    func nextPage(sender:UIButton!)
        {
            println("Button tapped")
            //let infoVC = UserInfoViewController()
            //let infoVC = UserInfoViewController(nibName: nil, bundle: nil)
            
            self.navigationController?.pushViewController(ViewController(), animated: true)
            
            //self.navigationController?.pushViewController(infoVC, animated: true)
            
            
    }
    
    func changePage(sender: AnyObject) -> () {
        
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        self.scrollView.setContentOffset(CGPointMake(x, 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) -> () {
        //println("aha")
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width);
        self.pageControl.currentPage = Int(pageNumber)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //println("yay")
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width);
        self.pageControl.currentPage = Int(pageNumber)
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}