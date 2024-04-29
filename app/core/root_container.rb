# frozen_string_literal: true

RootContainer = Di::Container.new(
  weighings_file_path: Di::Container.value_resolver("./storage/weighings.json"),
  weighing_entry_persistence: Di::Container.class_resolver(Infra::FsWeighingEntryPersistence),
  app_add_weighing: Di::Container.class_resolver(Application::AddWeighing),
  reader: Di::Container.value_resolver(Interface::StdinReader),
  writer: Di::Container.value_resolver(Interface::StdoutWriter),
  initial_ui: Di::Container.class_resolver(Interface::Ui::Initial),
  weighing_menu_ui: Di::Container.class_resolver(Interface::Ui::WeighingMenu),
  add_weighing_menu_ui: Di::Container.class_resolver(Interface::Ui::AddWeighingMenu),
  exit_transition: Di::Container.class_resolver(Interface::Transitions::Exit),
  list_weighings_transition: Di::Container.class_resolver(Interface::Transitions::ListWeighings),
  add_weighing_transition: Di::Container.class_resolver(Interface::Transitions::AddWeighing),
  command_line: Di::Container.class_resolver(Interface::CommandLine),
  list_weighings: Di::Container.class_resolver(Application::ListWeighings),
  delete_weighing_menu_ui: Di::Container.class_resolver(Interface::Ui::DeleteWeighingMenu),
  delete_weighing: Di::Container.class_resolver(Application::DeleteWeighing),
  print_weighings: Di::Container.class_resolver(Interface::Printers::PrintWeighings),
  delete_weighing_transition: Di::Container.class_resolver(Interface::Transitions::DeleteWeighing)
)
