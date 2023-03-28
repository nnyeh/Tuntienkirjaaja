// eslint-disable-next-line import/default
import bcrypt from 'bcrypt'
import { prisma } from '../../prisma/db'

export default defineEventHandler(async (event) => {
  const { email, firstName, lastName, password } = await readBody(event)
  // eslint-disable-next-line import/no-named-as-default-member
  const hashedPassword = await bcrypt.hash(password, 10)
  await prisma.user.create({
    data: {
      email,
      firstName,
      lastName,
      hashedPassword
    }
  })
  return {
    statusCode: 200
  }
})
