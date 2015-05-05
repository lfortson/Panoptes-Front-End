React = require 'react'
apiClient = require '../api/client'

module?.exports = React.createClass
  displayName: 'CollectionFavoritesButton'

  propTypes:
    subject: React.PropTypes.object # subject response from panoptes

  addSubjectTo: (collection) ->
    collection.addLink('subjects', [@props.subject.id.toString()])
      .then (collection) =>
        console.log "subject added to #{collection.display_name}"
        # update ui-state here
      .catch (e) -> throw new Error(e)

  removeSubjectFrom: (collection) ->
    collection.removeLink('subjects', [@props.subject.id.toString()])
      .then (collection) =>
        console.log "subject removed from #{collection.display_name}"
        # update ui-state here
      .catch (e) -> throw new Error(e)

  createFavorites: ->
    display_name = 'favorites'
    project = @props.subject.links.project
    links = {project}
    collection = {display_name, links}

    apiClient.type('collections').create(collection).save()
      .then (favorites) => @addSubjectTo(favorites)
      .catch (e) -> throw new Error(e)

  toggleFavorite: ->
    project_id = @props.subject.links.project
    display_name = 'favorites'

    # check for a favorites collection in project first
    apiClient.type('collections').get({project_id, display_name}).index(0)
      .then (favorites) =>
        if !!favorites
          console.log "favorites.id", favorites.id

          # try to request subject from favorites
          apiClient.type('subjects').get(collection_id: favorites.id, id: @props.subject.id).index(0)
            .then (subject) =>
              if subject
                @removeSubjectFrom(favorites)
              else
                @addSubjectTo(favorites)
            .catch (e) -> throw new Error(e)
        else
          @createFavorites()

  render: ->
    <button
      className="favorites-button"
      onClick={@toggleFavorite}>
      <i className="fa fa-heart" />
    </button>
