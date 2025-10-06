const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const TransliterationHistorySchema = new Schema({
  userId: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  originalText: {
    type: String,
    required: true
  },
  transliteratedText: {
    type: String,
    required: true
  },
  fromScript: {
    type: String,
    required: true
  },
  toScript: {
    type: String,
    required: true
  },
  isFromImage: {
    type: Boolean,
    default: false
  },
  date: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model('TransliterationHistory', TransliterationHistorySchema);