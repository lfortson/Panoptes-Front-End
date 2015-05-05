React = require 'react'
apiClient = require '../api/client'
getSubjectLocation = require '../lib/get-subject-location'
PromiseRenderer = require '../components/promise-renderer'
loadImage = require '../lib/load-image'
FavoritesButton = require '../collections/favorites-button'

module?.exports = React.createClass
  displayName: 'TalkSubjectDisplay'

  propTypes:
    focusId: React.PropTypes.number

  getInitialState: ->
    collectionFormOpen: true

  toggleCollectionForm: (e) ->
    @setState collectionFormOpen: !@state.collectionFormOpen

  toggleCollectionMembership: (collectionId) ->
    apiClient.type('collections', {})
      .get(collectionId.toString())
        .then (collection) =>
          collection.addLink('subjects', [@props.focusId.toString()])
            .then (coll) =>
              console.log "collection subjects added", collection
            .catch (e) -> console.log "error add subject to coll", e

  collectionCheckbox: (d, i) ->
    <label key={i} >
      <input
        type="checkbox"
        onChange={=> @toggleCollectionMembership(d.id)} />
        {d.display_name}
    </label>

  render: ->
    <div className="talk-subject-display">
      <PromiseRenderer promise={apiClient.type('subjects').get(@props.focusId.toString())}>{(subject) =>

        <div>
          {if @state.collectionFormOpen
            <div>
              <h1>Collect!</h1>
              <PromiseRenderer promise={apiClient.type('collections').get()}>{(collections) =>
                <div>
                  <div>{collections.map(@collectionCheckbox)}</div>
                  <FavoritesButton subject={subject} />
                </div>
              }</PromiseRenderer>
            </div>
            }

          <a href={getSubjectLocation(subject).src} target="_blank">
            <img src={getSubjectLocation(subject).src} />
          </a>
          <p>Subject {subject.id}</p>
          <span onClick={@toggleCollectionForm}>
            <i className="fa fa-th" />
          </span>
        </div>
      }</PromiseRenderer>
    </div>
