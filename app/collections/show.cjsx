React = require 'react'
PromiseToSetState = require '../lib/promise-to-set-state'
talkClient = require '../api/talk'

module?.exports = React.createClass
  displayName: 'CollectionShow'
  mixins: [PromiseToSetState]

  componentWillMount: ->
    @promiseToSetState collection: talkClient.type('collections').get({id: @props.params?.collection_id}).index(0)

  render: ->
    <div className="talk-image-collection">
      Collection Show:
      {@state.collection?.display_name}
    </div>
