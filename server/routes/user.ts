import { prisma } from '../../prisma/db'

export default defineEventHandler(async (event) => {
  const { email, firstName, lastName, password } = await readBody(event)
  const hashedPassword = password
  const createUser = await prisma.user.create({
    data: {
      email,
      firstName,
      lastName,
      hashedPassword
    }
  })
    .catch((error) => {
      console.error(error)
    })
  return createUser
})
