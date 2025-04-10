const mongoose = require('mongoose');

const autoReplyRuleSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    sessionId: {
        type: String,
        required: true
    },
    name: {
        type: String,
        required: true
    },
    isActive: {
        type: Boolean,
        default: true
    },
    triggerType: {
        type: String,
        enum: ['keyword', 'regex', 'exact', 'contains'],
        required: true
    },
    triggerValue: {
        type: String,
        required: true
    },
    responseType: {
        type: String,
        enum: ['text', 'image', 'template'],
        default: 'text'
    },
    responseContent: {
        type: String,
        required: true
    },
    imageUrl: {
        type: String
    },
    conditions: {
        timeRestricted: {
            type: Boolean,
            default: false
        },
        startTime: String,
        endTime: String,
        daysOfWeek: [Number], // 0-6 for Sunday-Saturday
        contactRestricted: {
            type: Boolean,
            default: false
        },
        allowedContacts: [String], // Phone numbers
        excludedContacts: [String] // Phone numbers
    },
    createdAt: {
        type: Date,
        default: Date.now
    },
    updatedAt: {
        type: Date,
        default: Date.now
    }
});

// Update the updatedAt field before saving
autoReplyRuleSchema.pre('save', function (next) {
    this.updatedAt = Date.now();
    next();
});

const AutoReplyRule = mongoose.model('AutoReplyRule', autoReplyRuleSchema);

module.exports = AutoReplyRule; 