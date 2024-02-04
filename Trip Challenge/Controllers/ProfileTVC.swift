////
////  ProfileTVC.swift
////  Trip Challenge
////
////  Created by Kate on 03/12/2023.
////

import UIKit

class ProfileTVC: UITableViewController {
    
    private var isLegalSectionExpanded = false
    
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
                case .appFeedback: return ""
                case .legal: return ""
                case .appInfo: return ""
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == ProfileSection.settings.rawValue && indexPath.row == 1 {
            presentMeasurementUnitActionSheet()
        }
        if indexPath.section == ProfileSection.legal.rawValue && indexPath.row == 0 {
               isLegalSectionExpanded.toggle()
               tableView.reloadSections([indexPath.section], with: .automatic)
           }
    }

    private func presentMeasurementUnitActionSheet() {
        let actionSheet = UIAlertController(title: "Выберите единицу измерения", message: nil, preferredStyle: .actionSheet)
        
        let kilometersAction = UIAlertAction(title: "Километры", style: .default) { _ in
            // Обработка выбора "Километры"
        }
        
        let milesAction = UIAlertAction(title: "Мили", style: .default) { _ in
            // Обработка выбора "Мили"
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        actionSheet.addAction(kilometersAction)
        actionSheet.addAction(milesAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
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
        case .legal:
            return isLegalSectionExpanded ? 2 : 1
            case .achievements, .profile, .appFeedback, .appInfo:
                return 1
            case .settings:
                return 3 // Язык, единицы измерения, уведомления
            default:
                return 1
            }
        }

      

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        switch ProfileSection(rawValue: indexPath.section) {
        case .achievements:
            cell.textLabel?.text = "Просмотреть мои достижения"
            cell.accessoryType = .disclosureIndicator // нажатие переводит на экран c достижениями

        case .profile:
            cell.textLabel?.text = "Редактировать профиль"
            cell.accessoryType = .disclosureIndicator

        case .settings:
            // Настройка ячеек для раздела "Настройки"
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Язык"
            case 1:
                cell.textLabel?.text = "Единицы измерения"
           cell.accessoryType = .disclosureIndicator
            case 2:
                let switchView = UISwitch(frame: .zero)
                switchView.setOn(true, animated: true)
                switchView.tag = indexPath.row // Тэг для идентификации свитчера
                switchView.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
                cell.accessoryView = switchView
                cell.textLabel?.text = "Уведомления"
            default:
                break
            }

        case .appFeedback:
            cell.textLabel?.text = "Оценить приложение"
            cell.accessoryType = .disclosureIndicator

        case .legal:
                if indexPath.row == 0 {
                    cell.textLabel?.text = "Пользовательское соглашение"
                    cell.accessoryType = .disclosureIndicator
                } else {
                    cell.textLabel?.text = "Все равно этот текст никто не читает, но пусть он будет: 1. Общие положения Пользовательского соглашения 1.1. В настоящем документе и вытекающих или связанным с ним отношениях Сторон применяются следующие термины и определения: а) Приложение — программно-аппаратные средства, интегрированные с Сайтом Администрации;б) Пользователь — дееспособное физическое лицо, присоединившееся к настоящему Соглашению в собственном интересе либо выступающее от имени и в интересах представляемого им юридического лица. в) Сайт  — интернет-сайты, размещенные в домене tripchallenge.com и его поддоменах. г) Сервис — комплекс услуг и лицензия, предоставляемые Пользователю с использованием Платформы. д) Соглашение - настоящее соглашение со всеми дополнениями и изменениями. Пользователь обязуется отдать душу дьяволу, если ему не понравится это приложение :)"
                    cell.textLabel?.numberOfLines = 0 // Позволяет тексту занимать несколько строк
                    cell.accessoryType = .none
                }
        case .appInfo:
            cell.textLabel?.text = "Версия приложения: 1.0.0"

        default:
            break
        }

        return cell
    }

    @objc func switchChanged(_ sender: UISwitch) {
        // Обработка изменения состояния UISwitch
        if sender.tag == 2 {
            // Изменение состояния уведомлений
        }
    }
        @objc private func logOutTapped() {
          
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
