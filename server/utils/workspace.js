const apiWithCache = require('./slack/apiWithCache')
const api = require('./slack/api')

const getTeams = async () => {
    let result = await apiWithCache.getAllTeams()
    let teams = result.usergroups.map(({ id, name, handle, prefs }) => ({
      id,
      name,
      handle,
      channels: prefs.channels
    })
      )
    return teams
  }  

  const getChannels = async () => {
    let result = await api.getAllChannels()
    let array = result.channels.filter(channel => !channel.is_archived && channel.num_members > 25)
    console.log(array.length)
    let channels = result.channels.map(
      ({ id, name }) => ({
        id,
        name
      })
    )
    return array
  }

  const getEmployees = async () => {
    let result = await apiWithCache.getAllUsers()
    let employees = result.members.map(
        ({ id, team_id, real_name, profile }) => ({
          id,
          team_id,
          real_name,
          images: _filterImagesFromProfile(profile)
        })
      )
    return employees
  }

  getEmployees()

 const getEmployeeById = async (employeeId) => {
    let result = await api.getUserById(employeeId)
    let {id, team_id, real_name, profile} = result.user
    let user = {
      id,
      team_id,
      real_name,
      images: _filterImagesFromProfile(profile)
    }
    return user
  }
  const _filterImagesFromProfile = profile => {
    return {
      icon: profile.image_24,
      pic: profile.image_72
    }
  }

module.exports = {
    getTeams,
    getEmployees,
    getChannels,
    getEmployeeById
}