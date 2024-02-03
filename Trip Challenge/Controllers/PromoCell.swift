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
    private let promoButton = UIButton()
    private let backgroundImageView = UIImageView()
    private var isPromoActivated = false
    
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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)

        // Description Label
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)

        // Promo Button
        promoButton.setTitle("View Promo", for: .normal)
        promoButton.backgroundColor = .blue
        promoButton.layer.cornerRadius = 5
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

        NSLayoutConstraint.activate([
            // Constraints for titleLabel, descriptionLabel, promoButton, and backgroundImageView
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            promoButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            promoButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            promoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            promoButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    @objc private func promoButtonTapped() {
            isPromoActivated.toggle() // Переключаем состояние активации
            updateUIForPromoState()
        }
    private func updateUIForPromoState() {
            if isPromoActivated {
                contentView.backgroundColor = .gray
                promoButton.setTitle("Купон активирован", for: .normal)
                promoButton.setImage(UIImage(named: "checkmarkIcon"), for: .normal) // Иконка галочки
            } else {
                contentView.backgroundColor = .systemMint
                promoButton.setTitle("View Promo", for: .normal)
                promoButton.setImage(nil, for: .normal)
            }
        }
    func configure(with promo: Promo) {
           titleLabel.text = promo.title
           descriptionLabel.text = promo.description
           // ... Остальная конфигурация ...
           isPromoActivated = false // Сброс состояния при конфигурации
           updateUIForPromoState()
       }
   }
