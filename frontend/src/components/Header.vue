<script setup lang="ts">
import { ref } from 'vue'
import { useSidebarStore } from '@/stores/sidebar'
import { useAuthStore } from '@/stores/auth'
import { useRouter } from 'vue-router'

const authStore = useAuthStore()
const router = useRouter()

const sidebarStore = useSidebarStore()

function handleLogout() {
	authStore.logout()
	router.push('/login')
}

</script>

<template>
	<nav class="navbar" role="navigation" aria-label="main navigation">
		<div class="navbar-brand">
			<a class="navbar-item" href="#">
				<p>logo</p>
			</a>

			<a
				role="button"
				class="navbar-burger has-text-white"
				aria-label="menu"
				aria-expanded="false"
				@click="sidebarStore.toggle({ isFromButton: true })"
			>
				<span aria-hidden="true"></span>
				<span aria-hidden="true"></span>
				<span aria-hidden="true"></span>
				<span aria-hidden="true"></span>
			</a>
		</div>

		<div id="navbarBasicExample" class="navbar-menu">
			<div class="navbar-end">
				<div class="navbar-item">
					<button class="button is-danger" @click="handleLogout">
						logout
					</button>
				</div>
			</div>
		</div>
	</nav>
</template>

<style scoped></style>
