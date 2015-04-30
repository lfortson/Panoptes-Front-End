React = require 'react'
PromiseToSetState = require '../lib/promise-to-set-state'
talkClient = require '../api/talk'

module?.exports = React.createClass
  displayName: 'CollectionShow'
  mixins: [PromiseToSetState]

  getInitialState: ->
    subjects: []
    collection: {}

  componentWillMount: ->
    @promiseToSetState {
      collection: talkClient.type('collections').get({id: @props.params?.collection_id}).index(0)
      subjects: talkClient.type('subjects').get()
      }

  componentWillUpdate: (p, s) ->
    console.log "state.collection", s.collection
    console.log "s.subjects", s.subjects

  subject: (d, i) ->
    <p key={i}>{d}</p>

  render: ->
    <div className="talk-image-collection">
      Collection Show:
      {@state.collection?.display_name}
      {@state.subjects.map(@subject)}
    </div>
