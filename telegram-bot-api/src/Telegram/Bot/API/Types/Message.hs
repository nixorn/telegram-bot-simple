{-# LANGUAGE DeriveGeneric #-}
module Telegram.Bot.API.Types.Message where

import Data.Aeson (FromJSON (..), ToJSON (..))
import Data.Text (Text)
import Data.Time.Clock.POSIX (POSIXTime)
import GHC.Generics (Generic)

import Telegram.Bot.API.Types.Animation
import Telegram.Bot.API.Types.Audio
import Telegram.Bot.API.Types.Document
import {-# SOURCE #-} Telegram.Bot.API.Types.Chat
import Telegram.Bot.API.Types.ChatShared
import Telegram.Bot.API.Types.Common
import Telegram.Bot.API.Types.Contact
import Telegram.Bot.API.Types.Dice
import Telegram.Bot.API.Types.ForumTopicEdited
import Telegram.Bot.API.Types.ForumTopicClosed
import Telegram.Bot.API.Types.ForumTopicCreated
import Telegram.Bot.API.Types.ForumTopicReopened
import Telegram.Bot.API.Types.Game
import Telegram.Bot.API.Types.InlineKeyboardMarkup
import Telegram.Bot.API.Types.Invoice
import Telegram.Bot.API.Types.Location
import Telegram.Bot.API.Types.MessageAutoDeleteTimerChanged
import Telegram.Bot.API.Types.MessageEntity
import Telegram.Bot.API.Types.PassportData
import Telegram.Bot.API.Types.PhotoSize
import Telegram.Bot.API.Types.Poll
import Telegram.Bot.API.Types.ProximityAlertTriggered
import Telegram.Bot.API.Types.Sticker
import Telegram.Bot.API.Types.SuccessfulPayment
import Telegram.Bot.API.Types.User
import Telegram.Bot.API.Types.UserShared
import Telegram.Bot.API.Types.Venue
import Telegram.Bot.API.Types.Video
import Telegram.Bot.API.Types.VideoChatEnded
import Telegram.Bot.API.Types.VideoChatScheduled
import Telegram.Bot.API.Types.VideoChatStarted
import Telegram.Bot.API.Types.VideoNote
import Telegram.Bot.API.Types.Voice
import Telegram.Bot.API.Types.WebAppData
import Telegram.Bot.API.Types.WriteAccessAllowed
import Telegram.Bot.API.Internal.Utils

-- ** Message

-- | This object represents a message.
data Message = Message
  { messageMessageId             :: MessageId -- ^ Unique message identifier inside this chat.
  , messageMessageThreadId       :: Maybe MessageThreadId -- ^ Unique identifier of a message thread to which the message belongs; for supergroups only.
  , messageFrom                  :: Maybe User -- ^ Sender, empty for messages sent to channels.
  , messageSenderChat            :: Maybe Chat -- ^ Sender of the message, sent on behalf of a chat. For example, the channel itself for channel posts, the supergroup itself for messages from anonymous group administrators, the linked channel for messages automatically forwarded to the discussion group. For backward compatibility, the field from contains a fake sender user in non-channel chats, if the message was sent on behalf of a chat.
  , messageDate                  :: POSIXTime -- ^ Date the message was sent in Unix time.
  , messageChat                  :: Chat -- ^ Conversation the message belongs to.
  , messageForwardFrom           :: Maybe User -- ^ For forwarded messages, sender of the original message.
  , messageForwardFromChat       :: Maybe Chat -- ^ For messages forwarded from channels, information about the original channel.
  , messageForwardFromMessageId  :: Maybe MessageId -- ^ For messages forwarded from channels, identifier of the original message in the channel.
  , messageForwardSignature      :: Maybe Text -- ^ For messages forwarded from channels, signature of the post author if present.
  , messageForwardSenderName     :: Maybe Text -- ^ Sender's name for messages forwarded from users who disallow adding a link to their account in forwarded messages.
  , messageForwardDate           :: Maybe POSIXTime -- ^ For forwarded messages, date the original message was sent in Unix time
  , messageIsTopicMessage        :: Maybe Bool -- ^ 'True', if the message is sent to a forum topic.
  , messageIsAutomaticForward    :: Maybe Bool -- ^ 'True', if the message is a channel post that was automatically forwarded to the connected discussion group.
  , messageReplyToMessage        :: Maybe Message -- ^ For replies, the original message. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.
  , messageViaBot                :: Maybe User -- ^ Bot through which the message was sent.
  , messageEditDate              :: Maybe POSIXTime -- ^ Date the message was last edited in Unix time
  , messageHasProtectedContent   :: Maybe Bool -- ^ 'True', if the message can't be forwarded.
  , messageMediaGroupId          :: Maybe MediaGroupId -- ^ The unique identifier of a media message group this message belongs to
  , messageAuthorSignature       :: Maybe Text -- ^ Signature of the post author for messages in channels
  , messageText                  :: Maybe Text -- ^ For text messages, the actual UTF-8 text of the message, 0-4096 characters.
  , messageEntities              :: Maybe [MessageEntity] -- ^ For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text
  , messageAnimation             :: Maybe Animation -- ^ Message is an animation, information about the animation. For backward compatibility, when this field is set, the document field will also be set.
  , messageAudio                 :: Maybe Audio -- ^ Message is an audio file, information about the file
  , messageDocument              :: Maybe Document -- ^ Message is a general file, information about the file.
  , messagePhoto                 :: Maybe [PhotoSize] -- ^ Message is a photo, available sizes of the photo
  , messageSticker               :: Maybe Sticker -- ^ Message is a sticker, information about the sticker
  , messageVideo                 :: Maybe Video -- ^ Message is a video, information about the video
  , messageVideoNote             :: Maybe VideoNote -- ^ Message is a video note, information about the video message
  , messageVoice                 :: Maybe Voice -- ^ Message is a voice message, information about the file
  , messageCaption               :: Maybe Text -- ^ Caption for the audio, document, photo, video or voice, 0-200 characters
  , messageCaptionEntities       :: Maybe [MessageEntity] -- ^ For messages with a caption, special entities like usernames, URLs, bot commands, etc. that appear in the caption.
  , messageHasMediaSpoiler       :: Maybe Bool -- ^ 'True', if the message media is covered by a spoiler animation.
  , messageContact               :: Maybe Contact -- ^ Message is a shared contact, information about the contact
  , messageDice                  :: Maybe Dice -- ^ Message is a dice with random value.
  , messageGame                  :: Maybe Game -- ^ Message is a game, information about the game. More about games »  , messageLocation              :: Maybe Location -- ^ Message is a shared location, information about the location
  , messagePoll                  :: Maybe Poll -- ^ Message is a native poll, information about the poll.
  , messageVenue                 :: Maybe Venue -- ^ Message is a venue, information about the venue
  , messageLocation              :: Maybe Location -- ^ Message is a shared location, information about the location.
  , messageNewChatMembers        :: Maybe [User] -- ^ New members that were added to the group or supergroup and information about them (the bot itself may be one of these members)
  , messageLeftChatMember        :: Maybe User -- ^ A member was removed from the group, information about them (this member may be the bot itself)
  , messageNewChatTitle          :: Maybe Text -- ^ A chat title was changed to this value
  , messageNewChatPhoto          :: Maybe [PhotoSize] -- ^ A chat photo was change to this value
  , messageDeleteChatPhoto       :: Maybe Bool -- ^ Service message: the chat photo was deleted
  , messageGroupChatCreated      :: Maybe Bool -- ^ Service message: the group has been created
  , messageSupergroupChatCreated :: Maybe Bool -- ^ Service message: the supergroup has been created. This field can‘t be received in a message coming through updates, because bot can’t be a member of a supergroup when it is created. It can only be found in reply_to_message if someone replies to a very first message in a directly created supergroup.
  , messageChannelChatCreated    :: Maybe Bool -- ^ Service message: the channel has been created. This field can‘t be received in a message coming through updates, because bot can’t be a member of a channel when it is created. It can only be found in reply_to_message if someone replies to a very first message in a channel.
  , messageAutoDeleteTimerChanged :: Maybe MessageAutoDeleteTimerChanged -- ^ Service message: auto-delete timer settings changed in the chat.
  , messageHasAggressiveAntiSpamEnabled :: Maybe Bool -- ^ 'True', if aggressive anti-spam checks are enabled in the supergroup. The field is only available to chat administrators. Returned only in 'getChat'.
  , messageHasHiddenMembers      :: Maybe Bool -- ^ 'True', if non-administrators can only get the list of bots and administrators in the chat. Returned only in 'getChat'.
  , messageMigrateToChatId       :: Maybe ChatId -- ^ The group has been migrated to a supergroup with the specified identifier. This number may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it is smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier.
  , messageMigrateFromChatId     :: Maybe ChatId -- ^ The supergroup has been migrated from a group with the specified identifier. This number may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it is smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier.
  , messagePinnedMessage         :: Maybe Message -- ^ Specified message was pinned. Note that the Message object in this field will not contain further reply_to_message fields even if it is itself a reply.
  , messageInvoice               :: Maybe Invoice -- ^ Message is an invoice for a payment, information about the invoice.
  , messageSuccessfulPayment     :: Maybe SuccessfulPayment -- ^ Message is a service message about a successful payment, information about the payment.
  , messageUserShared            :: Maybe UserShared -- ^ Service message: a user was shared with the bot.
  , messageChatShared            :: Maybe ChatShared -- ^ Service message: a chat was shared with the bot.
  , messageConnectedWebsite      :: Maybe Text -- ^ The domain name of the website on which the user has logged in.
  , messageWriteAccessAllowed    :: Maybe WriteAccessAllowed -- ^ Service message: the user allowed the bot added to the attachment menu to write messages.
  , messagePassportData          :: Maybe PassportData -- ^ Telegram Passport data.
  , messageProximityAlertTriggered :: Maybe ProximityAlertTriggered -- ^ Service message. A user in the chat triggered another user's proximity alert while sharing Live Location.
  , messageForumTopicCreated     :: Maybe ForumTopicCreated -- ^ Service message: forum topic created.
  , messageForumTopicEdited     :: Maybe ForumTopicEdited -- ^ Service message: forum topic edited.
  , messageForumTopicClosed     :: Maybe ForumTopicClosed -- ^ Service message: forum topic closed.
  , messageForumTopicReopened     :: Maybe ForumTopicReopened -- ^ Service message: forum topic reopened.
  , messageVideoChatScheduled    :: Maybe VideoChatScheduled -- ^ Service message: video chat scheduled.
  , messageVideoChatStarted      :: Maybe VideoChatStarted -- ^ Service message: video chat started
  , messageVideoChatEnded        :: Maybe VideoChatEnded -- ^ Service message: video chat ended.
  , messageVideoChatParticipantsInvited :: Maybe VideoChatParticipantsInvited -- ^ Service message: new participants invited to a video chat.
  , messageWebAppData            :: Maybe WebAppData -- ^ Service message: data sent by a Web App.
  , messageReplyMarkup           :: Maybe InlineKeyboardMarkup -- ^ Inline keyboard attached to the message. `login_url` buttons are represented as ordinary `url` buttons.
  }
  deriving (Generic, Show)

instance ToJSON   Message where toJSON = gtoJSON
instance FromJSON Message where parseJSON = gparseJSON
