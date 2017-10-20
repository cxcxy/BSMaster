import Foundation

public typealias ShareSuccessClosure                = () -> ()
public typealias ShareFailClosure                   = (_ e:Swift.Error) -> ()

public class BSShareManager {
    
    public static func config_init() {
        
        if let umm = UMSocialManager.default() {
            //打开日志
            umm.openLog(true)
            //设置友盟appkey
            umm.umSocialAppkey = BSShareID.UMeng.appID
            //设置微信的appKey和appSecret
            umm.setPlaform(.wechatSession, appKey: BSShareID.Wechat.appID, appSecret: BSShareID.Wechat.appKey, redirectURL: BSShareID.UMeng.share_url)
            // 获取友盟social版本号
            print("UMeng social version: \(UMSocialGlobal.umSocialSDKVersion())")
    
        }else{
            print(">>>> WowShare Init Fail!")
        }
    }
    static let vc = UIApplication.currentViewController()

    public static func handle_open_url(_ url:URL ) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        return result
    }
    public static func share_WechatImg(url:String?,
                                              shareImage:Any!,
                                              successClosure:@escaping ShareSuccessClosure,
                                              failClosure:@escaping ShareFailClosure){
        let messageObject                       = UMSocialMessageObject()
        let shareObject:UMShareImageObject    = UMShareImageObject.init()
        
        
        shareObject.thumbImage = shareImage
        shareObject.shareImage = url
        messageObject.shareObject               = shareObject
        
        UMSocialManager.default().share(to: UMSocialPlatformType.wechatSession, messageObject: messageObject, currentViewController: vc) { (shareResponse, error) in
            var _: String = ""
            if let e = error {
                
                failClosure(e )
            }else{
                
                successClosure()
            }
            
        }
    }

    public static func share_WechatFriendsImg(url:String?,
                                              shareImage:Any!,
                                              successClosure:@escaping ShareSuccessClosure,
                                              failClosure:@escaping ShareFailClosure){
        let messageObject                       = UMSocialMessageObject()
        let shareObject:UMShareImageObject    = UMShareImageObject.init()

    
        shareObject.thumbImage = shareImage
        shareObject.shareImage = url
         messageObject.shareObject               = shareObject
        
       UMSocialManager.default().share(to: UMSocialPlatformType.wechatTimeLine, messageObject: messageObject, currentViewController: vc) { (shareResponse, error) in
        var _: String = ""
            if let e = error {
                
                failClosure(e )
            }else{
         
                successClosure()
            }

        }
    }
    //分享朋友圈
    public static func share_friends(
        _ title:String = "欢迎您",
        shareText:String?,
        url:String?,
        shareImage:Any!,
        successClosure:@escaping ShareSuccessClosure,
        failClosure:@escaping ShareFailClosure
    )
    {
        let messageObject                       = UMSocialMessageObject()
        let shareObject:UMShareWebpageObject    = UMShareWebpageObject.init()
        shareObject.title                       = title       //显不显示有各个平台定
        shareObject.descr                       = shareText   //显不显示有各个平台定
        shareObject.thumbImage                  = shareImage  //缩略图，显不显示有各个平台定
        shareObject.webpageUrl                  = url
        messageObject.shareObject               = shareObject
        
        UMSocialManager.default().share(
            to: UMSocialPlatformType.wechatTimeLine,
            messageObject: messageObject,
            currentViewController: vc,
            completion: { (shareResponse, error) -> Void in
                
                var _: String = ""
                
                if let e = error {
                    failClosure(e )
                }else{
                    successClosure()
                }
    
            })
    }
    
    
    
    public static func share_text(
        _ title:String = "尖叫设计欢迎您",
        shareText:String?,
        url:String?,
        shareImage:Any!,
        successClosure:@escaping ShareSuccessClosure,
        failClosure:@escaping ShareFailClosure
    )
    {
        
        let messageObject                       = UMSocialMessageObject()
        let shareObject:UMShareWebpageObject    = UMShareWebpageObject.init()
        shareObject.title                       = title       //显不显示有各个平台定
        shareObject.descr                       = shareText   //显不显示有各个平台定
        shareObject.thumbImage                  = shareImage  //缩略图，显不显示有各个平台定
        shareObject.webpageUrl                  = url
        messageObject.shareObject               = shareObject
        
        UMSocialManager.default().share(
            to: UMSocialPlatformType.wechatSession,
            messageObject: messageObject,
            currentViewController: vc,
            completion: { (shareResponse, error) -> Void in
                print(error.debugDescription)
                var _: String = ""
                if let e = error {
                    failClosure(e )
                }else{
                    successClosure()
                }

                
        })

    }
    
    public static func cancle(  success_handler: @escaping (Any?) -> Void ){
        UMSocialManager.default().cancelAuth(with: UMSocialPlatformType.wechatSession) { (result, error) in
            if error != nil {
                print("Share Fail with error ：%@", error ?? "")
            }else{
                
                success_handler("sucess")
            }
        }
    
    }


}

