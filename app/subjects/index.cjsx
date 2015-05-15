React = require 'react'
apiClient = require '../api/client'
talkClient = require '../api/talk'
getSubjectLocation = require '../lib/get-subject-location'
FavoritesButton = require '../collections/favorites-button'
CollectionsManager = require '../collections/manager'
PromiseRenderer = require '../components/promise-renderer'

module?.exports = React.createClass
  displayName: 'Subject'

  getInitialState: ->
    subject: null

  componentWillMount: ->
    @setSubject()

  setSubject: ->
    subjectId = @props.params?.id.toString()
    apiClient.type('subjects').get(subjectId)
      .then (subject) =>
        @setState {subject}

  comment: (data, i) ->
    <p key={data.id}>{data.body}</p>

  render: ->
    {subject} = @state

    <div className="subject content-container">
      {if subject
        <section>
          <h1>Subject {subject.id}</h1>

          <img src={getSubjectLocation(subject).src} />

          <FavoritesButton subject={subject} />

          <PromiseRenderer promise={talkClient.type('comments').get({focus_id: subject.id})}>{(comments) =>
            if comments.length
              <div>
                <h2>Comments mentioning this subject:</h2>
                <p style={color:"red"}>Todo link to thread/comment</p>
                {comments.map(@comment)}
              </div>
            else
              <p>There are no comments focused on this subject</p>
          }</PromiseRenderer>

          <CollectionsManager subject={subject} />
        </section>
        }
      
      <br/>Place to add it to collections

      <br/>Tags about it

    </div>
