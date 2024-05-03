# frozen_string_literal: true

RootContainer = Di::Container.new(
  weighings_file_path: Di::Container.value_resolver("./storage/weighings.json"),
  weighing_entry_repository: Di::Container.class_resolver(Infra::FsWeighingEntryRepository),
  add_weighing: Di::Container.class_resolver(Application::AddWeighing),
  list_weighings: Di::Container.class_resolver(Application::ListWeighings),
  delete_weighing: Di::Container.class_resolver(Application::DeleteWeighing)
)
