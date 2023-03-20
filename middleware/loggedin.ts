export default defineNuxtRouteMiddleware(() => {
  const { status } = useSession()

  if (status.value === "unauthenticated") {
    return navigateTo("/")
  }
})
