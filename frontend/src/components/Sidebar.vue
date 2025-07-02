<script setup lang="ts">
import { RouterLink } from 'vue-router'
import { ref, onMounted, onBeforeUnmount } from 'vue'
import { useSidebarStore } from '@/stores/sidebar'
import { onClickOutside } from '@vueuse/core'
import NavlinkComponent from '@/components/NavlinkComponent.vue'

const navLinks = [
	{ name: 'Home', to: '/', icon: 'fas fa-home' },
	{ name: 'About', to: '/about' },
]

const sidebarStore = useSidebarStore()
const sidebarRef = ref(null)

onClickOutside(sidebarRef, () => {
	sidebarStore.close()
})
</script>

<template>
	<div
		class="sidebar has-background-grey is-100"
		:class="{ 'is-open': sidebarStore.isOpen }"
		ref="sidebarRef"
	>
		<aside class="menu">
			<p class="menu-label">Menu</p>
			<ul class="menu-list">
				<NavlinkComponent
					v-for="link in navLinks"
					:name="link.name"
					:to="link.to"
					:icon="link.icon"
				/>
			</ul>
		</aside>
	</div>
</template>
