<script setup lang="ts">
import { ref } from 'vue'
import { useAuthStore } from '@/stores/auth'
import { useRouter } from 'vue-router'

const authStore = useAuthStore()
const router = useRouter()

const email = ref('')
const password = ref('')
const username = ref('')

async function handleCreate() {
	try {
		await authStore.register(email.value, password.value, username.value)
		router.push('/login')
	} catch (error) {}
}
</script>

<template>
	<form @submit.prevent="handleCreate">
		<h1>Create user</h1>
		<div>
			<label for="email">Email</label>
			<input id="email" v-model="email" type="email" required />
		</div>

		<div>
			<label for="username">Username</label>
			<input id="username" v-model="username" type="username" required />
		</div>

		<div>
			<label for="password">Password</label>
			<input id="password" v-model="password" type="password" required />
		</div>

		<button type="submit" :disabled="authStore.loading">
			{{ authStore.loading ? 'Creating user...' : 'Create user' }}
		</button>

		<p v-if="authStore.error" class="error">
			{{ authStore.error }}
		</p>
	</form>
	<RouterLink to="/login">
		<button class="button is-link">Login</button>
	</RouterLink>
</template>

<style scoped>
.error {
	color: red;
}
</style>
