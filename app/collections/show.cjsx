React = require 'react'
PromiseToSetState = require '../lib/promise-to-set-state'
talkClient = require '../api/talk'
getSubjectLocation = require '../lib/get-subject-location'

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
    console.log "s.subjects", s.subjects

  subject: (d, i) ->
    <img key={i} src={'http://' + getSubjectLocation(d).src} />

  render: ->
    <div className="collections-show">
      Collection Show:
      <section>{@state.collection?.display_name}</section>
      <section>{@state.subjects.map(@subject)}</section>
    </div>
