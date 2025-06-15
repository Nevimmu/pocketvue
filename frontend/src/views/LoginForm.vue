<script setup lang="ts">
import { ref } from 'vue'
import { useAuthStore } from '@/stores/auth'
import { useRouter } from 'vue-router'

const authStore = useAuthStore()
const router = useRouter()

const email = ref('')
const password = ref('')

async function handleLogin() {
	try {
		await authStore.login(email.value, password.value)
		// Redirect or handle successful login
		router.push('/')
	} catch (error) {
		// Error is already handled in the store
	}
}
</script>

<template>
	<form class="box" @submit.prevent="handleLogin">
		<h1 class="has-text-primary">Login</h1>
		<div>
			<label for="email">Email</label>
			<input id="email" v-model="email" type="email" required />
		</div>

		<div>
			<label for="password">Password</label>
			<input id="password" v-model="password" type="password" required />
		</div>

		<button class="submit" :disabled="authStore.loading">
			{{ authStore.loading ? 'Logging in...' : 'Login' }}
		</button>

		<p v-if="authStore.error" class="error">
			{{ authStore.error }}
		</p>
	</form>
	<RouterLink to="/create">Create user</RouterLink>
</template>

<style scoped>
.error {
	color: red;
}
</style>
