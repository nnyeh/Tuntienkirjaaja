import { prisma } from '../../prisma/db'

export default defineEventHandler(async (event) => {
  const { email, firstName, lastName, password } = await readBody(event)
  const createUser = await prisma.user.create({
    data: {
      email,
      firstName,
      lastName,
      password
    }
  })
    .catch((error) => {
      console.error(error)
    })
  return createUser
})
