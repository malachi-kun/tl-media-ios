//
//  HomeArticleDetailCell.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/10.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class HomeArticleDetailCell:UICollectionViewCell {
    
    // MARK: UI COMPONENETS
    let articleHeaderImage:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "card01")
        return iv
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "I bomb atomically.  Socrates, philosphy, and high prophecies can't defining why I be dropping these mockery."
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let profileImage:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TL")
        iv.backgroundColor = .white
        iv.layer.cornerRadius = iv.frame.size.width/2
        iv.clipsToBounds = true
        return iv
    }()
    
    let authorNameLabel:UILabel = {
        let label = UILabel()
        label.text = "Person name"
        return label
    }()
    
    let issueDateLabel:UILabel = {
        let label = UILabel()
        label.text = "ISSUE"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.text = "2018/01/10"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let bodyLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        //label.backgroundColor = .green
        label.text = """
        僕、子どもの頃からドラえもんのフォルムが大好きで。今も、フィギュアとかぬいぐるみとかが家にいっぱい転がっています。でも、食べ物の好き嫌いと同じ感じで、理由はわかりません（笑）。内容もぜんぜん詳しくないですよ。最近、地元帰った時、友だちに「このドラえもんの鈴って何でついてるか知ってる？」って聞かれたけど、全然わからなくって。
        「ドラえもんのファンだ」って言うと、すぐ「じゃあ、ひみつ道具知ってる？」「何巻の何話の話やばいよね」みたいな話になりがちだけど、そういう、内容を詳しく知らないとファンじゃない、っていう考え方が苦手なんです。それはそれで何も間違ってない。でも、もっとファンのルールみたいなのがゆるくなるといいですよね。
        
        日本人は藤子先生の作品を崇高なものにしたがるでしょ。ドラえもんって、ミッキーとかスヌーピーに負けない世界的に人気なキャラクターになれると個人的に思ってるんですけど、日本人がファンのルールをきっちり決めてしまうから、日本をなかなか飛び越えられないんだろうなって。
        
        もっと内容どうこうじゃなくて、シンプルに、「やっぱすごいよね」ってことをみんなで言い合いたいっていう想いだけで、こういうことをやってるんです。
        僕、子どもの頃からドラえもんのフォルムが大好きで。今も、フィギュアとかぬいぐるみとかが家にいっぱい転がっています。でも、食べ物の好き嫌いと同じ感じで、理由はわかりません（笑）。内容もぜんぜん詳しくないですよ。最近、地元帰った時、友だちに「このドラえもんの鈴って何でついてるか知ってる？」って聞かれたけど、全然わからなくって。
        
        「ドラえもんのファンだ」って言うと、すぐ「じゃあ、ひみつ道具知ってる？」「何巻の何話の話やばいよね」みたいな話になりがちだけど、そういう、内容を詳しく知らないとファンじゃない、っていう考え方が苦手なんです。それはそれで何も間違ってない。でも、もっとファンのルールみたいなのがゆるくなるといいですよね。
        
        日本人は藤子先生の作品を崇高なものにしたがるでしょ。ドラえもんって、ミッキーとかスヌーピーに負けない世界的に人気なキャラクターになれると個人的に思ってるんですけど、日本人がファンのルールをきっちり決めてしまうから、日本をなかなか飛び越えられないんだろうなって。
        
        もっと内容どうこうじゃなくて、シンプルに、「やっぱすごいよね」ってことをみんなで言い合いたいっていう想いだけで、こういうことをやってるんです。
        もっと内容どうこうじゃなくて、シンプルに、「やっぱすごいよね」ってことをみんなで言い合いたいっていう想いだけで、こういうことをやってるんです。
        僕、子どもの頃からドラえもんのフォルムが大好きで。今も、フィギュアとかぬいぐるみとかが家にいっぱい転がっています。でも、食べ物の好き嫌いと同じ感じで、理由はわかりません（笑）。内容もぜんぜん詳しくないですよ。最近、地元帰った時、友だちに「このドラえもんの鈴って何でついてるか知ってる？」って聞かれたけど、全然わからなくって。
        
        「ドラえもんのファンだ」って言うと、すぐ「じゃあ、ひみつ道具知ってる？」「何巻の何話の話やばいよね」みたいな話になりがちだけど、そういう、内容を詳しく知らないとファンじゃない、っていう考え方が苦手なんです。それはそれで何も間違ってない。でも、もっとファンのルールみたいなのがゆるくなるといいですよね。
        
        日本人は藤子先生の作品を崇高なものにしたがるでしょ。ドラえもんって、ミッキーとかスヌーピーに負けない世界的に人気なキャラクターになれると個人的に思ってるんですけど、日本人がファンのルールをきっちり決めてしまうから、日本をなかなか飛び越えられないんだろうなって。
        
        もっと内容どうこうじゃなくて、シンプルに、「やっぱすごいよね」ってことをみんなで言い合いたいっていう想いだけで、こういうことをやってるんです。

        """
        return label
    }()
    
 
    

    
    // MARK: LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: ASSIST METHODS
    func setUpUI(){

        backgroundColor = .green
        
        addSubview(articleHeaderImage)
        articleHeaderImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 220)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: articleHeaderImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: -10, width: 0, height: 0)
        
        addSubview(profileImage)
        let topPad:CGFloat = 10, leftPad:CGFloat = 10
        profileImage.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: topPad, paddingLeft: leftPad, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        
        addSubview(authorNameLabel)
        authorNameLabel.anchor(top: titleLabel.bottomAnchor, left: profileImage.rightAnchor, bottom: nil, right: nil, paddingTop: topPad, paddingLeft: leftPad, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(issueDateLabel)
        let rightPad:CGFloat = 125
        issueDateLabel.anchor(top: titleLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: topPad, paddingLeft: 0, paddingBottom: 0, paddingRight: rightPad, width: 0, height: 0)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: titleLabel.bottomAnchor, left: issueDateLabel.rightAnchor, bottom: nil
            , right: rightAnchor, paddingTop: topPad, paddingLeft: leftPad, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(bodyLabel)
        bodyLabel.anchor(top: profileImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: topPad, paddingLeft: leftPad, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
    }
}
