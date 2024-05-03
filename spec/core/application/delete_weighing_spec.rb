require "rails_helper"

RSpec.describe "Application::DeleteWeighing" do
  def setup
    weighing_entry_repository = Infra::FsWeighingEntryRepository.new(
      weighings_file_path: "./storage/weighings.test.json"
    )

    existing_weighings = TestUtils::ArrayFactory.call(
      -> { TestUtils::WeighingEntryFactory.call },
      10
    )

    weighing_entry_repository.store(existing_weighings)

    {
      existing_weighings:,
      weighing_entry_repository:
    }
  end

  context "when there is a weighing entry associated with given id" do
    def second_setup
      result = setup

      existing_weighings = result[:existing_weighings]
      weighing_entry_repository = result[:weighing_entry_repository]

      weighing_to_be_deleted = existing_weighings.sample

      weighing_entry_repository.delete(weighing_to_be_deleted.id)

      stored_entries = weighing_entry_repository.retrieve_all

      {
        existing_weighings:,
        weighing_entry_repository:,
        weighing_to_be_deleted:,
        stored_entries:
      }
    end

    it "deletes the weighing entry" do
      result = second_setup

      existing_weighings = result[:existing_weighings]
      stored_entries = result[:stored_entries]
      weighing_to_be_deleted = result[:weighing_to_be_deleted]

      expect(stored_entries).to match_array(existing_weighings - [weighing_to_be_deleted])
    end
  end

  context "when there is NO weighing entry associated with given id" do
    def second_setup
      result = setup

      existing_weighings = result[:existing_weighings]
      weighing_entry_repository = result[:weighing_entry_repository]

      non_existent_id = Random.uuid

      stored_entries = weighing_entry_repository.retrieve_all

      {
        existing_weighings:,
        weighing_entry_repository:,
        non_existent_id:,
        stored_entries:
      }
    end

    it "raises an error and leaves existing entries untouched" do
      result = second_setup

      weighing_entry_repository = result[:weighing_entry_repository]
      non_existent_id = result[:non_existent_id]
      existing_weighings = result[:existing_weighings]
      stored_entries = result[:stored_entries]

      aggregate_failures do
        expect { weighing_entry_repository.delete(non_existent_id) }.to raise_error do |error|
          expect(error.tags).to match_array(%i[WeighingEntryRepository FailedToDelete WeighingEntryNotFound])
        end

        expect(existing_weighings).to match_array(stored_entries)
      end
    end
  end
end
