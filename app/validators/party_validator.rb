class PartyValidator < ActiveModel::Validator
  def validate(record)
  	movie = MovieFacade.movie_details(record.movie_id)
    if record.duration.to_i < movie.runtime_min
      record.errors.add :base, "Duration cannot be shorter than movie runtime "
    end
  end
 end