
import UIKit
import AZSClient

class ViewController: UIViewController {
    
    let connStr = "DefaultEndpointsProtocol=https;AccountName=codingstr2;AccountKey=NQKaG+dQJEYXF1Guwd4q7gHRvZPuzEJzzDoEXO9XY5CyWcaotcR14xNuKQLC0IwLqnpKkYlsQKwLfq/ghtN8OQ==;EndpointSuffix=core.windows.net"
    
    var containerA: AZSCloudBlobContainer!
    var clientA: AZSCloudBlobClient!
    
    @IBOutlet var btnA: UIButton!
    @IBOutlet var btnB: UIButton!
    @IBOutlet var btnC: UIButton!
    @IBOutlet var txfA: UITextField!
    @IBOutlet var lblA: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 컨테이너 추가
        let stAccount: AZSCloudStorageAccount = try! AZSCloudStorageAccount(fromConnectionString: self.connStr)
        clientA = stAccount.getBlobClient()
        containerA = clientA.containerReference(fromName: "codingstr")
        containerA.createContainerIfNotExists { (errA, isOK) in
            if errA != nil {
                print("Error in creating container.")
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    
    @IBAction func btnPressedA() {
        
        // Blob 추가
        let strA = self.txfA.text!
        let blobA: AZSCloudBlockBlob = containerA.blockBlobReference(fromName: "text1")
        blobA.upload(fromText: strA) { (errA) in
            if errA != nil {
                print("err up")
                print(errA!)
            } else {
                print("suc up")
            }
        }
        
    }
    
    @IBAction func btnPressedB() {
        
        // Blob 삭제
        let blobA: AZSCloudBlockBlob = containerA.blockBlobReference(fromName: "text1")
        blobA.delete(with: AZSDeleteSnapshotsOption.none) { (errA) in
            if errA != nil {
                print("err del")
                print(errA!)
            } else {
                print("suc del")
            }
        }
        
    }
    
    @IBAction func btnPressedC() {
        
        // Blob 다운
        let blobA: AZSCloudBlockBlob = containerA.blockBlobReference(fromName: "text1")
        blobA.downloadToData { (errA, dataA) in
            if errA != nil {
                print("err down")
                print(errA!)
            } else {
                print("suc down")
                let downText = String(data: dataA!, encoding: String.Encoding.utf8)
                DispatchQueue.main.async {
                    self.lblA.text = downText
                }
            }
        }
    }
    
}


/*
 https://docs.microsoft.com/ko-kr/azure/storage/blobs/storage-ios-how-to-use-blob-storage 참조
 
 블록 Blob: 이미지 파일 등
 추가 Blob: 텍스트 파일 등
 */
