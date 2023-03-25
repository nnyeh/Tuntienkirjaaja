import { prisma } from '../../prisma/db'

export default defineEventHandler(async (event) => {
  const { email, task } = await readBody(event)

  const user = await prisma.user.findUnique({
    where: {
      email
    },
    select: {
      id: true
    }
  })

  const deleteTaskPreset = await prisma.userTaskPresets.delete({
    where: {
      task_userId: {
        userId: user!.id,
        task
      }
    }
  })
  return deleteTaskPreset
})
