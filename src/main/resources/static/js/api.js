class ApiService {
    constructor() {
        this.baseUrl = '';
    }

    async request(endpoint, options = {}) {
        const url = `${this.baseUrl}${endpoint}`;
        const config = {
            headers: {
                'Content-Type': 'application/json',
                ...options.headers,
            },
            ...options,
        };

        if (config.body && typeof config.body === 'object') {
            config.body = JSON.stringify(config.body);
        }

        try {
            const response = await fetch(url, config);

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const contentType = response.headers.get('content-type');
            if (contentType && contentType.includes('application/json')) {
                return await response.json();
            }
            return await response.text();
        } catch (error) {
            console.error('API request failed:', error);
            throw error;
        }
    }

    // Dashboard
    async getDashboard() {
        return await this.request('/api/dashboard');
    }

    // Caisses
    async getCaisses() {
        return await this.request('/api/caisses');
    }

    async getCaisse(id) {
        return await this.request(`/api/caisses/${id}`);
    }

    async createCaisse(caisse) {
        return await this.request('/api/caisses', {
            method: 'POST',
            body: caisse,
        });
    }

    async updateCaisse(id, caisse) {
        return await this.request(`/api/caisses/${id}`, {
            method: 'PUT',
            body: caisse,
        });
    }

    async deleteCaisse(id) {
        return await this.request(`/api/caisses/${id}`, {
            method: 'DELETE',
        });
    }

    async toggleCaisseStatus(id) {
        return await this.request(`/api/caisses/${id}/toggle`, {
            method: 'PATCH',
        });
    }

    // Tests
    async getTests() {
        return await this.request('/api/tests');
    }

    async getTest(id) {
        return await this.request(`/api/tests/${id}`);
    }

    async createTest(test) {
        return await this.request('/api/tests', {
            method: 'POST',
            body: test,
        });
    }

    async updateTest(id, test) {
        return await this.request(`/api/tests/${id}`, {
            method: 'PUT',
            body: test,
        });
    }

    async deleteTest(id) {
        return await this.request(`/api/tests/${id}`, {
            method: 'DELETE',
        });
    }

    async toggleTestStatus(id) {
        return await this.request(`/api/tests/${id}/toggle`, {
            method: 'PATCH',
        });
    }
}

const apiService = new ApiService();