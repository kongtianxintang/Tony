/*
 @Description: 程序提示
 @Date:  2021/8/19
 */

import UIKit
import Toaster

class PwToast {
    
    class func showToast(text:String?){
        let t = Toast.init(text:text , delay: 0, duration: 2);
        t.show();
    }

}
