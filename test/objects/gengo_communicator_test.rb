# frozen_string_literal: true
require_relative '../test_helper'

class GengoCommunicatorTest < ActiveSupport::TestCase # to have fixtures
  let(:communicator) { GengoCommunicator.new }

  # before do
  #   Net::HTTP.any_instance.stubs(:request)
  # end

  describe '#create_translation_jobs' do
    it 'should call Gengo postTranslationJobs with a job for every locale'\
       ' (except de/en)' do
      I18n.stub :available_locales, [:de, :en, :fo, :ob, :ar] do
        object = OpenStruct.new(id: 99, field_en: 'foobar')

        base_job = {
          tier: 'standard', type: 'text', max_chars: 255, auto_approve: 1,
          lc_src: 'en',
          comment: 'It\'s for a web app to help refugees in Germany to find'\
                   ' help. Please use very simple / easy to understand'\
                   ' language.',
          purpose: 'Web content. Describing help for refugees in Germany',
          tone:    'Friendly, Informal'
        }
        Gengo::API.any_instance.expects(:postTranslationJobs).with(
          jobs: [
            base_job.merge(
              lc_tgt: 'fo', body_src: 'foobar', slug: 'OpenStruct:99:field_fo'
            ),
            base_job.merge(
              lc_tgt: 'ob', body_src: 'foobar', slug: 'OpenStruct:99:field_ob'
            ),
            base_job.merge(
              lc_tgt: 'ar', body_src: 'foobar', slug: 'OpenStruct:99:field_ar'
            )
          ]
        )

        communicator.create_translation_jobs object, 'field'
      end
    end
  end

  describe '#fetch_newly_approved_jobs' do
    it 'calls getTranslationJobs and returns the response' do
      Gengo::API.any_instance.expects(:getTranslationJobs)
                .with(
                  status: 'approved',
                  timestamp_after: (Time.zone.now - 25.hours).to_i
                ).returns('response' => 'bla')
      communicator.fetch_newly_approved_jobs.must_equal 'bla'
    end
  end

  describe '#fetch_job' do
    it 'calls getTranslationJob and returns the job response' do
      Gengo::API.any_instance.expects(:getTranslationJob)
                .with(id: 123).returns('response' => { 'job' => 'bla' })
      communicator.fetch_job(123).must_equal 'bla'
    end
  end
end
