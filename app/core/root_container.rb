# frozen_string_literal: true

RootContainer = Di::Container.new(
  weighings_file_path: Di::Container.value_resolver("./storage/weighings.json"),
  weighing_entry_repository: Di::Container.class_resolver(Infra::FsWeighingEntryRepository),
  add_weighing: Di::Container.class_resolver(Application::AddWeighing),
  list_weighings: Di::Container.class_resolver(Application::ListWeighings),
  delete_weighing: Di::Container.class_resolver(Application::DeleteWeighing),
  list_foods: Di::Container.class_resolver(Application::ListFoods),
  food_repository: Di::Container.class_resolver(Infra::FsFoodRepository),
  foods_file_path: Di::Container.value_resolver("./storage/foods.json"),
  add_food: Di::Container.class_resolver(Application::AddFood),
  show_food: Di::Container.class_resolver(Application::ShowFood),
)
