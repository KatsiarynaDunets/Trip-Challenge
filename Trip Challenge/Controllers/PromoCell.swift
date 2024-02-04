//
//  PromoCell.swift
//  Trip Challenge
//
//  Created by Kate on 04/12/2023.
//

import UIKit

class PromoCell: UICollectionViewCell {
    // UI Components
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let discountLabel = UILabel()
    private let promoButton = UIButton()
    private let backgroundImageView = UIImageView()
    private var isPromoActivated = false
    private var lastActivatedTime: Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        // Title Label
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        contentView.addSubview(titleLabel)
        
        // discount Label
        discountLabel.font = UIFont.systemFont(ofSize: 32)
        discountLabel.textColor = .white
        discountLabel.numberOfLines = 1
        contentView.addSubview(discountLabel)
        
        // Description Label
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)

        // Promo Button
        promoButton.setTitle("Активировать", for: .normal)
        promoButton.backgroundColor = .systemMint
        promoButton.layer.cornerRadius = 15
        promoButton.addTarget(self, action: #selector(promoButtonTapped), for: .touchUpInside)
        contentView.addSubview(promoButton)

        // Background Image View
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        contentView.insertSubview(backgroundImageView, at: 0)
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        promoButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        discountLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Constraints for titleLabel, descriptionLabel, discountLabelб promoButton, and backgroundImageView
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            discountLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            discountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 200),
            discountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 200),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            promoButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            promoButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            promoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            promoButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    @objc private func promoButtonTapped() {
           guard canActivatePromo() else { return }

           isPromoActivated = true
           lastActivatedTime = Date()
           updateUIForPromoState()

           // Отключаем кнопку на 24 часа
           promoButton.isEnabled = false
           DispatchQueue.main.asyncAfter(deadline: .now() + 86400) { [weak self] in
               self?.promoButton.isEnabled = true
               self?.isPromoActivated = false
               self?.updateUIForPromoState()
           }
       }

       private func canActivatePromo() -> Bool {
           guard let lastActivated = lastActivatedTime else { return true }
           return Date().timeIntervalSince(lastActivated) >= 86400 // 24 часа в секундах
       }

       private func updateUIForPromoState() {
           if isPromoActivated {
               contentView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
               promoButton.setTitle("Купон активирован", for: .normal)
               promoButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
           } else {
               contentView.backgroundColor = UIColor.systemMint.withAlphaComponent(0.3)
               promoButton.setTitle("Активировать", for: .normal)
               promoButton.setImage(nil, for: .normal)
           }
       }

    func configure(with promo: Promo) {
           titleLabel.text = promo.title
           descriptionLabel.text = promo.description
            discountLabel.text = promo.discount
           isPromoActivated = false // Сброс состояния при конфигурации
           updateUIForPromoState()
       }
    
    
   }
