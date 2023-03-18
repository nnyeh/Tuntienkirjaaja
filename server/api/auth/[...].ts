import CredentialsProvider from 'next-auth/providers/credentials'
// eslint-disable-next-line import/default
import bcrypt from 'bcrypt'
import { prisma } from '../../../prisma/db'
import { NuxtAuthHandler } from '#auth'

export default NuxtAuthHandler({
  pages: {
    signIn: "/"
  },
  secret: process.env.AUTH_SECRET,
  providers: [
    // @ts-expect-error
    CredentialsProvider.default({
      async authorize (credentials: any) {
        const user = await prisma.user.findUnique({
          where: {
            email: credentials.email
          },
          select: {
            email: true,
            hashedPassword: true
          }
        })

        // eslint-disable-next-line import/no-named-as-default-member
        if (bcrypt.compareSync(credentials.password, user!.hashedPassword)) {
          return user
        } else {
          console.error('Warning: Malicious login attempt registered, bad credentials provided')
          return null
        }
      }
    })
  ]
})
