class Entry < ApplicationRecord
  enum entry_status: { entered: 0, match: 1, match_rejected: 2, cancel: 3, done: 4 }
end
