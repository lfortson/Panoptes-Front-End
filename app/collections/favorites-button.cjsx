React = require 'react'
apiClient = require '../api/client'

module?.exports = React.createClass
  displayName: 'FavoritesButton'

  propTypes:
    subject: React.PropTypes.object # subject response from panoptes

  onClick: (e) ->
    console.log "onClick fave button", e

  createFavorites: ->
    console.log "creating favorites coll"
    display_name = 'favorites'
    project = @props.subject.links.project
    links = {project}
    collection = {display_name, links}

    apiClient.type('collections').create(collection).save()
      .then (collection) =>
        console.log "favorites saved", collection
      .catch (e) -> throw new Error(e)

  addSubjectToFavorites: ->
    return "TODO - add subject to favorites"

  componentDidMount: ->
    project_id = @props.subject.links.project
    name = 'favorites'

    # check for a favorites collection in project first
    apiClient.type('collections').get({project_id, name})
      .then (favorites) =>
        console.log "favorites", favorites
        if favorites?.length
          # add subject to favorites
          # set favorited display
          console.log "found favorites coll"
        else
          # create favorites, then add subject to it
          console.log "didn't find favorites, better create it..."
          @createFavorites()

  render: ->
    <button
      className="favorites-button"
      onClick={@onClick}>
      <i className="fa fa-heart" />
    </button>
