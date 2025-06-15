<script setup lang="ts">
import { RouterView, useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import Sidebar from './components/Sidebar.vue'
import FooterComponent from './components/FooterComponent.vue'
import Header from './components/Header.vue'

const authStore = useAuthStore()
const router = useRouter()

</script>

<template>
	<div class="grid-container">
		<div class="columns">
			<div class="column is-narrow p-0-mobile">
				<Sidebar v-if="authStore.isAuthenticated"/>
			</div>
			<div class="column">
				<Header v-if="authStore.isAuthenticated"/>
				<RouterView />
			</div>
		</div>
		<FooterComponent v-if="authStore.isAuthenticated"/>
	</div>
</template>

<style scoped>
.grid-container {
	grid-template-rows: 1fr auto;
	grid-template-areas: 'content', 'footer';
	display: grid;
	min-height: 100vh;
}
</style>
