require_relative '../test_helper'

describe Offer do
  let(:offer) { Offer.new }

  subject { offer }

  describe '::Base' do
    describe 'associations' do
      it { subject.must have_many :offer_mailings }
      it { subject.must have_many(:informed_emails).through :offer_mailings }
    end

    # describe 'scopes' do
    #   it 'excludes offers that are not approved' do
    #     unapproved_offer = FactoryGirl.create :offer, :approved
    #     Offer.approved.to_a.should include(unapproved_offer)
    #   end
    # end

    describe 'partial_dup' do
      it 'should correctly duplicate an offer' do
        offer = FactoryGirl.create :offer, :approved
        duplicate = offer.partial_dup
        duplicate.created_by.must_equal nil
        duplicate.location.must_equal offer.location
        duplicate.organizations.must_equal offer.organizations
        duplicate.openings.must_equal offer.openings
        duplicate.categories.must_equal offer.categories
        duplicate.section_filters.must_equal offer.section_filters
        duplicate.language_filters.must_equal offer.language_filters
        duplicate.target_audience_filters.must_equal offer.target_audience_filters
        duplicate.websites.must_equal offer.websites
        duplicate.contact_people.must_equal offer.contact_people
        duplicate.keywords.must_equal offer.keywords
        duplicate.area.must_equal offer.area
        duplicate.aasm_state.must_equal 'initialized'
      end
    end
  end
end
