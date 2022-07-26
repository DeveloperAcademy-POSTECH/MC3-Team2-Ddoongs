//
//  CategoryViewController.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/26.
//

import UIKit

// TODO: 액션 시트에서 단어 카테고리 이동? 무슨말.
// TODO: MyBoardViewController에서 navigation large 적용 필요.

struct Constants {
    static let cellInterval: CGFloat = 24
}
class CategoryViewController: UIViewController {

    fileprivate let reuseIdentifier = "wordCell"
    fileprivate let reuseHeaderIdentifier = "wordCell"
    fileprivate let data = ["q", "w", "e", "r"]
    
    fileprivate var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var keyBoard: UIButton = {
        let button = UIButton()
        let boldSearch = UIImage(systemName: "keyboard")
        button.setImage(boldSearch, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(saveSelector), for: .touchUpInside)
      return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        registerCollectionView()
        collectionViewDelegate()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        // TODO: category name 들어감
        configureNavigationBar(withTitle: "My Board")
    }
    
    fileprivate func configureNavigationBar(withTitle title: String) {
        
        navigationItem.title = title
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(goEditViewController)),
            UIBarButtonItem(customView: keyBoard )
        ]
    }
    
    @objc fileprivate func goEditViewController() {
        let categoryEditViewController = CategoryEditViewController()
        navigationController?.pushViewController(categoryEditViewController, animated: true)
    }
    // MARK: Header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        CGSize(width: collectionView.bounds.width, height: 80)
        
    }
    
    fileprivate func registerCollectionView() {
//        collectionView.register(CollectionViewCell.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.register(CategoryCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier)
        
    }
    fileprivate func collectionViewDelegate() {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    fileprivate func configureUI() {
        let vstack = UIStackView(arrangedSubviews: [collectionView])
        vstack.axis = .vertical
        vstack.spacing = 5
        view.addSubview(vstack)
        
        vstack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
        
        collectionView.backgroundColor = .systemGray6
        
//        tableView.rowHeight = 80
        // tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
//        tableView.tableFooterView = UIView()// 2개가 있다면 2개까지만 seperate line 보이도록.
        
    }
}
extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return data.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
                    cell.wordLabel.text = data[indexPath.row]
            return cell
        }

}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellInterval
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
//            guard let item = trackManager.todaysTrack else {
//                return UICollectionReusableView()
//            }
            
            // 커스텀셀을 가져오는 것처럼 커스텀 헤더 뷰를 가져온다.
            // 헤더나 푸터의 경우 디큐리유서블 서플먼트해야한다.
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeaderIdentifier, for: indexPath) as? CategoryCollectionHeaderView else {
                return UICollectionReusableView()
            }
            
            // 오늘의 곡 아이템 업데이트
            header.update()
 
//            print("taphanlder")
//            header.tapHandler = { item in
//                let playerStoryboard = UIStoryboard.init(name: "Player", bundle: nil)
//                //Player는 저 아래에도 있다. Player는 파일이름.
//                guard let playerVC = playerStoryboard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
//                //let item = trackManager.tracks[indexPath.item]
//                //simplePlayer는 싱글톤.
//                playerVC.simplePlayer.replaceCurrentItem(with: item)
//                self.present(playerVC, animated: true, completion: nil)
//            }
            // 교수
            return header
        default:
            return UICollectionReusableView()
        }
    }

}

class CategoryCollectionHeaderView: UICollectionReusableView {
    
    fileprivate let  addMyOwnWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Add My Own Word"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    fileprivate let  plusButtonImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "plus.circle")!
        imageView.image = image
        imageView.tintColor = .lightGray
        
        return imageView
    }()
    
//    var item: AVPlayerItem?
    var tapHandler: (() -> Void)?// 클로져
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
//    var yourViewBorder = CAShapeLayer()
//    yourViewBorder.strokeColor = UIColor.black.cgColor
//    yourViewBorder.lineDashPattern = [2, 2]
//    yourViewBorder.frame = yourView.bounds
//    yourViewBorder.fillColor = nil
//    yourViewBorder.path = UIBezierPath(rect: yourView.bounds).cgPath
//    yourView.layer.addSublayer(yourViewBorder)
    
    func update() {
    
        let containerView = UIView()
        containerView.addShadow()
        self.addSubview(containerView)
        
        containerView.backgroundColor = .white
        containerView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 6, paddingLeft: 1, paddingBottom: 24, paddingRight: 1)
        
        let hstack = UIStackView(arrangedSubviews: [plusButtonImage, addMyOwnWordLabel])
        plusButtonImage.setWidth(width: 30)
        plusButtonImage.setHeight(height: 30)
        hstack.axis = .horizontal
        hstack.spacing = 10
        containerView.addSubview(hstack)
        containerView.addDashedBorder(x: self.frame.size.width - 2, y: 50)
        hstack.centerX(inView: containerView)
        hstack.centerY(inView: containerView)
        
    }
}

class CollectionViewCell: UICollectionViewCell {
    
    var wordLabel = UILabel()
     
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
        
    }
    
    lazy var ellipsisButton: UIButton = {
        let button = UIButton()
        
        var image = UIImage(systemName: "ellipsis")!
        button.setImage(image, for: .normal)
        button.tintColor = .black
//      button.addTarget(self, action: #selector(editCategory), for: .touchUpInside)
        return button
    }()
    
    func setUpCell() {
        
        let containerView = UIView()
        containerView.addShadow()
        
        self.contentView.addSubview(containerView)
        
        containerView.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        let hstack = UIStackView(arrangedSubviews: [wordLabel, ellipsisButton])
        hstack.axis = .horizontal
        containerView.addSubview(hstack)
        
        hstack.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, left: containerView.safeAreaLayoutGuide.leftAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, right: containerView.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24)
        
        }
}
extension UIView {
    
    func addDashedBorder(x: CGFloat, y: CGFloat) {
        let color = UIColor.lightGray.cgColor

        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let shapeRect = CGRect(x: 0, y: 0, width: x, height: y)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: x/2, y: y/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6, 3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    
    func addShadow() {
        
        self.layer.cornerRadius = 10
        
        self.layer.shadowOpacity = 0.1

        self.layer.shadowOffset = CGSize(width: 3, height: 1)

        self.layer.shadowRadius = 8

        self.layer.masksToBounds = false
        
        self.backgroundColor = .white
    }
    
}
