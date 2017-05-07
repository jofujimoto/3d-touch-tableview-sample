//
//  MainViewController.swift
//  ThreeDTouchSample
//
//  Created by 藤本譲 on 2017/05/07.
//  Copyright © 2017年 jofujimoto. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIViewControllerPreviewingDelegate
{
    @IBOutlet weak var tblBase: UITableView!
    
    fileprivate var titleList: Array<String> = ["タイトル１", "タイトル２", "タイトル３", "タイトル４", "タイトル５", "タイトル６", "タイトル７", "タイトル８", "タイトル９", "タイトル１０"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // 3D Touch
        if self.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            registerForPreviewing(with: self, sourceView: tblBase)
        }
    }
    
    // 長押しされた時に呼ばれる
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController?
    {
        // 長押しされたセルのindexを取得
        guard let indexPath = tblBase.indexPathForRow(at: location) else {
            return nil
        }
        
        // 長押しされたセルを取得
        guard let cell = tblBase.cellForRow(at: indexPath) else {
            return nil
        }
        
        // Peek画面を生成
        let peek = UIStoryboard(name: "ThreeDTouchPeek", bundle: nil).instantiateViewController(withIdentifier: "ThreeDTouchPeek") as! ThreeDTouchPeekViewController
        peek.paramTitle = titleList[indexPath.row]

        // Peek画面の表示領域を設定
        peek.preferredContentSize = CGSize(width: 0.0, height: 200)

        // 長押しされたセルをハイライト表示
        var frm = cell.frame
        frm.origin.y = frm.origin.y + tblBase.contentOffset.y
        previewingContext.sourceRect = view.convert(frm, from: tblBase)

        return peek
    }
    
    // さらに深く押されたときに呼ばれる
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController)
    {
        // Peek画面を表示する
        show(viewControllerToCommit, sender: self)
        
        // 他の画面を表示する処理を実装してもOK
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: CustomTableCell = tableView.dequeueReusableCell(withIdentifier: "CustomTableCell")! as! CustomTableCell
        
        cell.setData(title: titleList[indexPath.row])
        
        return cell
    }

}

