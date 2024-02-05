//
//  PopularRoutesVC.swift
//  Trip Challenge
//
//  Created by Kate on 19/11/2023.
//


import UIKit

class TrendingChallengesVC: UIViewController {
    var challengeImageView = UIImageView()
    var titleLabel = UILabel()
    var categoryLabel = UILabel()
    var ratingLabel = UILabel()
    var poiCountLabel = UILabel()
    var descriptionLabel = UILabel()

    var challenge: Challenge? // Предполагается, что Challenge - это ваша модель данных

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configureView()
    }

    private func setupViews() {
        view.addSubview(challengeImageView)
        view.addSubview(titleLabel)
        view.addSubview(categoryLabel)
        view.addSubview(ratingLabel)
        view.addSubview(poiCountLabel)
        view.addSubview(descriptionLabel)

        challengeImageView.contentMode = .scaleAspectFill
        challengeImageView.clipsToBounds = true

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center

        categoryLabel.font = UIFont.systemFont(ofSize: 16)
        categoryLabel.textAlignment = .left

        ratingLabel.font = UIFont.systemFont(ofSize: 16)
        ratingLabel.textAlignment = .right

        poiCountLabel.font = UIFont.systemFont(ofSize: 16)
        poiCountLabel.textAlignment = .right

        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
    }

    private func setupConstraints() {
        challengeImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        poiCountLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            challengeImageView.topAnchor.constraint(equalTo: view.topAnchor),
            challengeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            challengeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            challengeImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),

            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),

            poiCountLabel.trailingAnchor.constraint(equalTo: ratingLabel.trailingAnchor),
            poiCountLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 10),

            descriptionLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func configureView() {
        guard let challenge = challenge else { return }

        titleLabel.text = challenge.challengeTitle
        categoryLabel.text = challenge.challengeCategory
        ratingLabel.text = "⭐️ \(challenge.challengeRating)"
        poiCountLabel.text = "POIs: \(challenge.pointsOfInterest.count)"
        descriptionLabel.text = challenge.challengeDescription

        if let imageData = challenge.challengeImage, let image = UIImage(data: imageData) {
            challengeImageView.image = image
        } else {
            challengeImageView.image = UIImage(named: "defaultImage")
        }
    }
}


// import UIKit
//
// class TrendingChallengesTVC: UITableViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //  selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        //  display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
//
//    /*
//     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//         // Configure the cell...
//
//         return cell
//     }
//     */
//
//    /*
//     // Override to support conditional editing of the table view.
//     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//         // Return false if you do not want the specified item to be editable.
//         return true
//     }
//     */
//
//    /*
//     // Override to support editing the table view.
//     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//         if editingStyle == .delete {
//             // Delete the row from the data source
//             tableView.deleteRows(at: [indexPath], with: .fade)
//         } else if editingStyle == .insert {
//             // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//         }
//     }
//     */
//
//    /*
//     // Override to support rearranging the table view.
//     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//     }
//     */
//
//    /*
//     // Override to support conditional rearranging of the table view.
//     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//         // Return false if you do not want the item to be re-orderable.
//         return true
//     }
//     */
//
//    /*
//     // MARK: - Navigation
//
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         // Get the new view controller using segue.destination.
//         // Pass the selected object to the new view controller.
//     }
//     */
// }
