
describe Peep do

    describe '#all method' do
      it 'tests all method exists and returns an Array' do
        expect(Peep.all).to be_instance_of Array
      end
  
      it 'returns all bookmarks' do
        Peep.add('I am extremely tired, but looking forward to this week!!', 1, 'Janie-P')
        Peep.add('Woof Woof Ledley, very lovely to woofers you!!', 2, 'Lucas')
        Peep.add('Woof Woof Lucas, likewoofs... looking forward to a walk with you soon!', 3, 'Ledley')
        
        peeps = Peep.all
  
        this_peep = peeps.first
        
        expect(peeps.length).to eq 3
        expect(peeps.first).to be_a Peep
        expect(peeps.first.id).to eq this_peep.id
        expect(peeps.first.username).to eq 'Janie-P'
      end 
  
    end
  
    # describe '#add bookmark method' do
    #   it 'tests add a new bookmark' do
    #     bookmark = Bookmark.add_bookmark('http://www.example.org', 'Example').first
    #     expect(bookmark['title']).to eq 'Example'
    #   end
    # end
  
    # describe '#delete bookmark method' do
    #   it 'tests delete a bookmark' do
    #     Bookmark.add_bookmark('http://www.example.org', 'Example')
    #     Bookmark.add_bookmark('http://www.google.com','google')
    #     this_bookmark = Bookmark.all.first
    #     expect(Bookmark.all.length).to eq 2
    #     Bookmark.delete(this_bookmark.id)
    #     expect(Bookmark.all.length).to eq 1
    #   end
    # end
  
  end
  