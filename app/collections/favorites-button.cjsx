React = require 'react'
apiClient = require '../api/client'
auth = require '../api/auth'

getFavoritesName = (project) ->
  #--> Naming Convention: "Favorites for #{project_name}"
  #    Prevents global uniqueness validation conflict under project scope
  "Favorites for #{project?.display_name}"

module?.exports = React.createClass
  displayName: 'CollectionFavoritesButton'

  propTypes:
    subject: React.PropTypes.object # a subject response from panoptes

  getInitialState: ->
    favorited: false

  componentWillMount: ->
    project_id = @props.subject.links.project.toString()

    apiClient.type('projects').get(project_id)
      .then (project) =>
        display_name = getFavoritesName(project)

        apiClient.type('collections').get({project_id, display_name}).index(0)
          .then (favorites) =>
            if !!favorites
              apiClient.type('subjects').get(collection_id: favorites.id, id: @props.subject.id).index(0)
                .then (subject) => @setState favorited: !!subject
                .catch (e) -> throw new Error(e)

  addSubjectTo: (collection) ->
    collection.addLink('subjects', [@props.subject.id.toString()])
      .then (collection) => @setState favorited: true
      .catch (e) -> throw new Error(e)

  removeSubjectFrom: (collection) ->
    collection.removeLink('subjects', [@props.subject.id.toString()])
      .then (collection) => @setState favorited: false
      .catch (e) -> throw new Error(e)

  createFavorites: ->
    project_id = @props.subject.links.project.toString()

    apiClient.type('projects').get(project_id)
      .then (project) =>
        display_name = getFavoritesName(project)
        project = @props.subject.links.project

        auth.checkCurrent().then (user) =>
          owner = {id: user.id.toString(), type: "users"} #--> must supply type
          links = {project, owner}
          collection = {display_name, links}

          apiClient.type('collections').create(collection).save()
            .then (favorites) =>
              @addSubjectTo(favorites)
            .catch (e) -> throw new Error(e)

  toggleFavorite: ->
    project_id = @props.subject.links.project.toString()

    apiClient.type('projects').get(project_id)
      .then (project) =>
        display_name = getFavoritesName(project)
        # check for a favorites collection in project first
        apiClient.type('collections').get({project_id, display_name}).index(0)

          .then (favorites) =>
            # try to request subject from favorites collection, otherwise create it

            if !!favorites
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
      <i className="fa fa-heart#{if @state.favorited then '' else '-o'}" />
    </button>
