author("William S. Burroughs", "Naked Lunch").
author("The Almighty God", "The Holy Bible (Old Testament)").
author("The Almighty God", "The Holy Bible (New Testament)").
author("Kurt Vonnegut", "Catch 22").
author("Kurt Vonnegut", "Slaughterhouse Five").
author("Dave Eggers", "The Circle").

plays("Eric Clapton", "guitar").
plays("Ravi Shankar", "sitar").
plays("George Harrison", "guitar").
plays("Ginger Baker", "drums").
plays("Mike Oldfield", "tubular bells").
plays("Flea", "bass guitar").
plays("Bootsie Collins", "bass guitar").

%% plays(Musician, "guitar").

genre("Eric Clapton", "rock").
genre("Ravi Shankar", "world").
genre("George Harrison", "rock").
genre("Ginger Baker", "rock").
genre("Mike Oldfield", "electronic").
genre("Flea", "rock").
genre("Bootsie Collins", "funk").

genre_uses_instrument(Genre, Instrument) :- plays(X, Instrument), genre(X, Genre).

%% ?- genre_uses_instrument(Genre, "bass guitar").
%% Genre = "rock" ;
%% Genre = "funk".

