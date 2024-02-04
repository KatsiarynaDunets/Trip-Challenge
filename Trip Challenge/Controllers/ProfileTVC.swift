////
////  ProfileTVC.swift
////  Trip Challenge
////
////  Created by Kate on 03/12/2023.
////

import UIKit

class ProfileTVC: UITableViewController {

        enum ProfileSection: Int, CaseIterable {
            case achievements
            case profile
            case settings
            case appFeedback
            case legal
            case appInfo

            var title: String {
                switch self {
                case .achievements: return "Достижения"
                case .profile: return "Профиль"
                case .settings: return "Настройки"
                case .appFeedback: return "Оценить приложение"
                case .legal: return "Пользовательское соглашение"
                case .appInfo: return "Информация о приложении"
                }
            }
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Профиль"
            setupTableView()
        }

        private func setupTableView() {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }

        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            return ProfileSection.allCases.count
        }

        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return ProfileSection(rawValue: section)?.title
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch ProfileSection(rawValue: section) {
            case .achievements, .profile, .appFeedback, .legal, .appInfo:
                return 1
            case .settings:
                return 3 // Язык, единицы измерения, уведомления
            default:
                return 0
            }
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            // Настройка ячейки в зависимости от секции и строки
            // ...

            return cell
        }

        // MARK: - Table view delegate

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            // Обработка нажатий на ячейки
            // ...
        }

        // Добавьте кнопку выхода
        override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            if section == ProfileSection.allCases.count - 1 { // Последняя секция
                let footerView = UIView()
                let logOutButton = UIButton(type: .system)
                logOutButton.setTitle("Выйти", for: .normal)
                logOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
                footerView.addSubview(logOutButton)
                logOutButton.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    logOutButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
                    logOutButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
                ])
                return footerView
            }
            return nil
        }

        @objc private func logOutTapped() {
            // Обработка нажатия на кнопку "Выйти"
            // ...
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
