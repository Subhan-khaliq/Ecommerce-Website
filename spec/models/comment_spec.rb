# # frozen_string_literal: true

require 'rails_helper'
RSpec.describe Comment, type: :model do
  subject { described_class.new }

  it 'is valid with valid attributes' do
    subject.content = 'Anything'
    subject.id = 1
    expect(subject).to_not be_valid
  end

  it 'is not valid without a content' do
    comment = Comment.new(content: nil)
    expect(comment).to_not be_valid
  end
end
